; Interpret as 64 bits code
[bits 64]

; nu uitati sa scrieti in feedback ca voiati
; assembly pe 64 de biti

section .text
global map
global reduce
map:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa turneu'

    push rbx

    push r12
    push r13
    push r14
    push r15

    ;; destinatie vector
    mov r13, rdi
    ;; sursa vector
    mov r14, rsi
    ;; dimensiune vector
    mov r15, rdx
    ;; functia de map
    mov r12, rcx

    ;; rbx = index, porneste de la 0
    xor rbx, rbx

.start_loop:
    cmp rbx, r15
    jge .end_loop

    ;; rsi -> sursa + index
    mov rdi, [r14 + rbx * 8]
    ;; apela functia de map
    call r12

    ;; rdi -> destinatie + index * sizeof(int)(x64)
    mov [r13 + rbx * 8], rax

    inc rbx
    jmp .start_loop
.end_loop:
    pop r15
    pop r14
    pop r13
    pop r12

    pop rbx

    leave
    ret


; int reduce(int *dst, int *src, int n, int acc_init, int(*f)(int, int));
; int f(int acc, int curr_elem);
reduce:
    ; look at these fancy registers
    push rbp
    mov rbp, rsp

    ; sa-nceapa festivalu'

    push rbx
    push r12
    push r13
    push r14

    ;; sursa vector
    mov r13, rsi
    ;; dimensiune vector
    mov r14, rdx
    ;; acc_init
    mov rax, rcx
    ;; functia de reduce
    mov r12, r8

    ;; rbx = index, porneste de la 0
    xor rbx, rbx

.loop_start:
    cmp rbx, r14
    jge .loop_end

    ;; rdi = acc_init
    mov rdi, rax

    ;;rsi = src + index
    mov rsi, [r13 + rbx * 8]
    call r12

    inc rbx
    jmp .loop_start

.loop_end:

    pop r14
    pop r13
    pop r12
    pop rbx

    leave
    ret

