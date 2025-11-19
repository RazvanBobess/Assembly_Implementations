; subtask 1 - qsort

section .text
    global quick_sort
    ;; no extern functions allowed

quick_sort:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    pusha
    ;; recursive qsort implementation goes here

    ;; restore the preserved registers

    ;; push end index
    mov eax, [ebp + 12]
    ;; push start index
    mov edx, [ebp + 16]

    cmp eax, edx
    jge .end

    ;;
    mov ebx, [ebp + 8]
    ;;
    mov ecx, [ebx + edx * 4]

    ;; esi = i
    mov esi, eax
    ;; edi = j
    mov edi, eax
.for_loop:
    cmp edi, edx
    jge .swap_pivot

    ;;
    cmp [ebx + edi * 4], ecx
    jg .skip_swap

    push eax
    push edx
    ;;
    mov eax, [ebx + esi*4]
    ;;
    mov edx, [ebx + edi*4]

    ;;
    mov [ebx + esi*4], edx
    ;;
    mov [ebx + edi*4], eax

    pop edx
    pop eax

    inc esi

.skip_swap:
    inc edi
    jmp .for_loop

.swap_pivot:
    push eax

    ;;
    mov eax, [ebx + esi*4]
    ;;
    mov ecx, [ebx + edx*4]
    ;;
    mov [ebx + esi*4], ecx
    ;;
    mov [ebx + edx*4], eax

    pop eax

    dec esi

    push esi
    push eax
    push ebx
    call quick_sort

    ;;
    add esp, 12
    ;;
    add esi, 2

    push edx
    push esi
    push ebx
    call quick_sort

    ;;
    add esp, 12

.end:
    popa

    leave
    ret
