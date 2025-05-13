// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

@SCREEN
D=A
@addr
M=D

(LOOP)
    
    @KBD
    D=M
    @BLACK
    D;JGT   

    @WHITE
    0;JMP  

(BLACK)
    @addr
    D=M
    @KBD
    D=A-D
    @END_BLACK
    D;JLE 

    @addr
    A=M
    M=-1  

    @addr
    M=M+1 

    @BLACK
    0;JMP  

(END_BLACK)
    @LOOP
    0;JMP  

(WHITE)
    @addr
    D=M
    @KBD
    D=A-D
    @END_WHITE
    D;JLE  

    @addr
    A=M
    M=0    

    @addr
    M=M+1  

    @WHITE
    0;JMP 

(END_WHITE)
    @LOOP
    0;JMP  