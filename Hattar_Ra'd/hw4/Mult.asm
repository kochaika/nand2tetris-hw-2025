// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm


// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)


    .data   
    .text   
    .globl _start

_start:
    // Initialize registers
    mov     r2, #0      
    cmp     r1, #0      
    beq     DONE        

MULT_LOOP:
    add     r2, r2, r0  
    subs    r1, r1, #1  
    bne     MULT_LOOP   

DONE:
    
    mov     r7, #1      
    mov     r0, #0     
    svc     0     
