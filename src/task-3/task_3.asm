%include "../include/io.mac"

; The `expand` function returns an address to the following type of data
; structure.
struc neighbours_t
    .num_neighs resd 1  ; The number of neighbours returned.
    .neighs resd 1      ; Address of the vector containing the `num_neighs` neighbours.
                        ; A neighbour is represented by an unsigned int (dword).
endstruc

section .bss
; Vector for keeping track of visited nodes.
visited resd 10000
global visited

section .data
; Format string for printf.
fmt_str db "%u", 10, 0

section .text
global dfs
extern printf

; C function signiture:
;   void dfs(uint32_t node, neighbours_t *(*expand)(uint32_t node))
; where:
; - node -> the id of the source node for dfs.
; - expand -> pointer to a function that takes a node id and returns a structure
; populated with the neighbours of the node (see struc neighbours_t above).
; 
; note: uint32_t is an unsigned int, stored on 4 bytes (dword).
dfs:
    push ebp
    mov ebp, esp

    ; TODO: Implement the depth first search algorith, using the `expand`
    ; function to get the neighbours. When a node is visited, print it by
    ; calling `printf` with the format string in section .data.

    push ebx
    push esi
    push edi

    ;; eax = id-ul nodului de start, aflata la adresa ebp + 8
    mov eax, [ebp + 8]

    ;; verificam daca nodul a fost vizitat
    ;; valoarea 4
    cmp BYTE [visited + eax], 1
    je .done

    ;; valoarea 1
    mov BYTE [visited + eax], 1

    ;; Printam nodul vizitat (curent)
    push eax
    push fmt_str
    call printf
    ;; adaugam 8 la esp pentru a elimina argumentele de pe stiva
    add esp, 8

    ;; obtinem vecinii nodului
    mov eax, [ebp + 8]
    push eax
    ;; ecx = functia de expand aflata la adresa ebp + 12
    mov ecx, [ebp + 12]
    call ecx

    ;; adaugam 4 la esp pentru a elimina argumentele de pe stiva
    add esp, 4

    ;;structura neighbours_t este in ebx
    ;;numarul de neighbouri este in [ebx + 0x0]
    mov ebx, [eax + neighbours_t.num_neighs]
    mov esi, [eax + neighbours_t.neighs]

    ;; edx -> index in vectorul de neighbouri
    xor edx, edx

.loop:
    cmp edx, ebx
    jge .done

    ;;
    mov edi, [esi + edx * 4]

    ;;
    cmp BYTE [visited + edi], 0
    jne .skiip

    ;; apelam recursiv dfs
    mov ecx, [ebp + 12]
    push edx
    push ecx
    push edi
    call dfs

    ;;
    add esp, 8
    pop edx

    ;; incrementam contorul edx
.skiip:
    inc edx
    jmp .loop

.done:

    pop edi
    pop esi
    pop ebx

    leave
    ret
