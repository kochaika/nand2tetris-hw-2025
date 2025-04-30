// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.
(LOOP)
    @KBD
    D=M
    @WHITE
    D;JEQ // go to white if not pressed
    @BLACK
    D;JNE // go to black if pressed
    @LOOP
    0;JMP // go the loop again

(BLACK)
    @R0
    M=0
    (LOOP1)
        @R0
        D=M
        @SCREEN
        A=D+A
        M=-1
        //
        @R0
        M=M+1
        D=M
        @8191
        D=A-D
        @LOOP1
        D;JGE
    @LOOP
    0;JMP // go the initial loop when finished
     
(WHITE)
    @R0
    M=0
    (LOOP2)
        @R0
        D=M
        @SCREEN
        A=D+A
        M=0
        //
        @R0
        M=M+1
        D=M
        @8191
        D=A-D
        @LOOP2
        D;JGE
    @LOOP
    0;JMP // go the initial loop when finished
