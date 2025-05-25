// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

@KBD
D=M
@DRAW_BLACK
D;JNE
@DRAW_WHITE
0;JMP

(DRAW_BLACK)
    @SCREEN
    D=A
    @addr
    M=D
    @8192
    D=A
    @count
    M=D

(BLACK_LOOP)
    @addr
    A=M
    M=-1
    @addr
    M=M+1
    @count
    MD=M-1
    @BLACK_LOOP
    D;JGT
    @LOOP
    0;JMP

(DRAW_WHITE)
    @SCREEN
    D=A
    @addr
    M=D
    @8192
    D=A
    @count
    M=D

(WHITE_LOOP)
    @addr
    A=M
    M=0
    @addr
    M=M+1
    @count
    MD=M-1
    @WHITE_LOOP
    D;JGT
    @LOOP
    0;JMP

(LOOP)
    @KBD
    D=M
    @DRAW_BLACK
    D;JNE
    @DRAW_WHITE
    0;JMP