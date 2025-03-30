// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.



    .data
    SCREEN_ADDR  .word  0x100000
    BLACK_COLOR  .word  0x000000
    WHITE_COLOR  .word  0xFFFFFF
    SCREEN_SIZE  .word  640*480

    .text
    .globl _start

_start:
LOOP:
    bl      CHECK_KEY_PRESS
    cmp     r0, #0
    beq     FILL_WHITE
    b       FILL_BLACK

FILL_BLACK:
    ldr     r1, =SCREEN_ADDR
    ldr     r2, =BLACK_COLOR
    bl      FILL_SCREEN
    b       LOOP

FILL_WHITE:
    ldr     r1, =SCREEN_ADDR
    ldr     r2, =WHITE_COLOR
    bl      FILL_SCREEN
    b       LOOP

CHECK_KEY_PRESS:
    mov     r0, #0
    bx      lr

FILL_SCREEN:
    ldr     r3, =SCREEN_SIZE
    mov     r4, r1
FILL_LOOP:
    str     r2, [r4], #4
    subs    r3, r3, #1
    bne     FILL_LOOP
    bx      lr
