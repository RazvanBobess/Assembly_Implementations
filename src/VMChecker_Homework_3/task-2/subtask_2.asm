; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push esi
    ;; recursive bsearch implementation goes here

    ;;start
    mov ebx, [ebp + 8]
    ;;end
    mov esi, [ebp + 12]

    cmp ebx, esi
    jg .not_found

    add ebx, esi
    ;;
    shr ebx, 1
    ;;
    cmp [ecx + ebx * 4], edx
    je .find

    jg .left
    ;; right
    mov esi, [ebp + 12]
    push esi
    inc ebx
    push ebx

    call binary_search
    ;;
    add esp, 8
    jmp .end_binary_search

.left:
    dec ebx
    push ebx
    ;;
    mov esi, [ebp + 8]
    push esi

    call binary_search
    ;;
    add esp, 8
    jmp .end_binary_search

.find:
    mov eax, ebx
    jmp .end_binary_search

    ;; not found

.not_found:
    ;;
    mov eax, -1
    jmp .end_binary_search

    ;; restore the preserved registers
.end_binary_search:
    pop esi
    pop ebx
    leave
    ret
