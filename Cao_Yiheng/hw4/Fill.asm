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
    @BLACK
    D;JGT
    
    @0
    D=A
    @i
    M=D

(CLEAR_LOOP)
    @i
    D=M
    @8192
    D=D-A
    @LOOP
    D;JEQ

    @SCREEN
    A=D+M
    M=0

    @i
    M=M+1
    @CLEAR_LOOP
    0;JMP
    

(BLACK)
    @0
    D=A
    @i
    M=D

(BLACK_LOOP)
    @i
    D=M
    @8192
    D=D-A
    @LOOP
    D;JEQ

    @SCREEN
    A=D+M
    M=-1

    @i
    M=M+1
    @BLACK_LOOP
    0;JMP



