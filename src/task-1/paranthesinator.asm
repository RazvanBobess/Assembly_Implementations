; Interpret as 32 bits code
[bits 32]

%include "../include/io.mac"

section .text
; int check_parantheses(char *str)
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp

    ; sa-nceapa concursul

    ;; ecx = 0, voi folosi ecx pe post de contor

    ;; eax o sa fie un registru care retine paranteza curenta
    ;; ebx o sa fie urmatoarea paranteaza, care poate sa fie o paranteza deschisa sau inchisa ( '(' sau ')' sau '[' sau ']' sau '{' sau '}' )
    ;; daca ebx este o paranteza deschisa, pun pe stiva eax si ii dau lui eax vahoarea lui ebx
    ;; daca ebx este o paranteza inchisa, verific daca eax este paranteza deschisa corespunzatoare lui ebx
    ;; daca este corespunzatoare, scot de pe stiva eax, ebx devine 0 si continui
    ;; ahtfel, returnez 1

    ;; ebx = primul caracter
    mov edx, [ebp + 8]
    dec edx
.while:
    ;; 
    inc edx
    mov al, BYTE [edx]
    ;;
    cmp al, 0
    je .endwhile

    ;; '('
    cmp al, '('
    je .paranteze_deschise

    ;; '['
    cmp al, '['
    je .paranteze_deschise

    ;; '{'
    cmp al, '{'
    je .paranteze_deschise            

    cmp esp, ebp
    je .return1

    ;; ')'
    cmp al, ')'
    je .paranteze_rotunde_inchise

    ;; ']'
    cmp al, ']'
    je .paranteze_patrate_inchise

    ;; '}'
    cmp al, '}'
    je .acolada_inchise 

.paranteze_deschise:
    dec esp
    mov [esp], al
    jmp .while

.paranteze_rotunde_inchise:
    mov ah, [esp]
    inc esp
    cmp ah, '('
    jne .return1

    jmp .while

.paranteze_patrate_inchise:
    mov ah, [esp]
    inc esp 
    cmp ah, '['
    jne .return1

    jmp .while

.acolada_inchise:
    mov ah, [esp]
    inc esp
    cmp ah, '{'
    jne .return1

    jmp .while

.endwhile:
    cmp esp, ebp
    jne .return1
    ;;
    mov eax, 0
    jmp .endfunction

.return1:
    ;;
    mov eax, 1

.endfunction:

    leave
    ret
