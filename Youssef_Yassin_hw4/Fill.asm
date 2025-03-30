section .data
array resb 10         ; Reserve 10 bytes for the array
fill_value db 7       ; Value to fill

section .text
global _start

_start:
    mov ecx, 10       ; Loop counter
    lea rdi, [array]  ; Load address of array
    mov al, [fill_value] ; Load value to fill

fill_loop:
    mov [rdi], al     ; Store value
    inc rdi           ; Move to next byte
    loop fill_loop    ; Decrement ECX and repeat if not zero

    ; Exit program
    mov eax, 60        ; syscall: exit
    xor edi, edi       ; status 0
    syscall
