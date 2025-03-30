section .text
    global _start

_start:
    mov ah, 00h  
    int 16h

    cmp al, 0
    je clear_screen 
    jmp fill_screen

fill_screen:
    mov ah, 0Bh
    mov bh, 00h
    mov bl, 00h
    int 10h
    jmp _start 

clear_screen:
    mov ah, 0Bh  
    mov bh, 00h
    mov bl, 07h
    int 10h
    jmp _start 