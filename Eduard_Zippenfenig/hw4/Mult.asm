section .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    result_msg db "The product is: ", 0

section .bss
    num1 resb 2
    num2 resb 2
    product resb 4

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt1
    mov edx, 20
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 20
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 2
    int 0x80

    sub byte [num1], '0'
    sub byte [num2], '0'
    
    movzx eax, byte [num1]
    movzx ebx, byte [num2]
    xor ecx, ecx 

multiply_loop:
    cmp ebx, 0
    je print_result
    add ecx, eax 
    dec ebx
    jmp multiply_loop

print_result:
    add ecx, '0'
    mov [product], ecx

    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 17
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, product
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
