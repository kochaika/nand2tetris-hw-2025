// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.

(MAIN_LOOP)
    @KBD
    D=M

    @FILL_SCREEN
    D;JGT

    @CLEAR_SCREEN
    0;JMP

(FILL_SCREEN)
    @8192
    D=A
    @counter
    M=D

    @SCREEN
    D=A
    @current_pixel
    M=D
    (FILL_LOOP)
        @counter
        D=M
        @MAIN_LOOP
        D;JEQ

        @current_pixel
        A=M
        M=-1
        @current_pixel
        M=M+1

        @counter
        M=M-1

        @FILL_LOOP
        0;JMP

(CLEAR_SCREEN)
    @8192
    D=A
    @counter
    M=D

    @SCREEN
    D=A
    @current_pixel
    M=D
    (CLEAR_LOOP)
        @counter
        D=M
        @MAIN_LOOP
        D;JEQ

        @current_pixel
        A=M
        M=0
        @current_pixel
        M=M+1

        @counter
        M=M-1

        @CLEAR_LOOP
        0;JMP

