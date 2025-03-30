section .text
global _start

_start:
    mov eax, 5         ; First number
    mov ebx, 3         ; Second number
    mul ebx            ; Multiply EAX by EBX (result in EAX)
    
    ; Exit program
    mov eax, 60        ; syscall: exit
    xor edi, edi       ; status 0
    syscall
