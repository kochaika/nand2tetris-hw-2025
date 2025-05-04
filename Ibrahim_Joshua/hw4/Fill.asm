// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/fill/Fill.asm

// Fill.asm
// Continuously checks if a key is pressed
// If pressed, fill the screen with black (all 1s)
// If not pressed, clear the screen (all 0s)

(LOOP)
    @KBD
    D=M
    @FILL_BLACK
    D;JNE          // If any key is pressed, jump to FILL_BLACK

// Clear the screen to white (0)
    @SCREEN
    D=A
    @addr
    M=D            // addr = SCREEN base address

(CLEAR_LOOP)
    @addr
    A=M
    M=0            // Set pixel to white

    @addr
    D=M
    @KBD
    D=A-D
    @LOOP
    D;JEQ          // If all screen cleared, return to LOOP

    @addr
    M=M+1          // addr++
    @CLEAR_LOOP
    0;JMP

(FILL_BLACK)
    @SCREEN
    D=A
    @addr
    M=D            // addr = SCREEN base address

(BLACK_LOOP)
    @addr
    A=M
    M=-1           // Set pixel to black (all 1s)

    @addr
    D=M
    @KBD
    D=A-D
    @LOOP
    D;JEQ          // If all screen filled, return to LOOP

    @addr
    M=M+1          // addr++
    @BLACK_LOOP
    0;JMP
