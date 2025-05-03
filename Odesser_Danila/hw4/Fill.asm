// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.
//Infinte loop

(INF_LOOP)
    @KBD
    D=M
    @BLACK
    D;JNE
    @WHITE
    0;JMP
@INF_LOOP
0;JMP


(BLACK)
@R1
M=-1
@SCREEN
D=A
@R0
M=D
@FILL_SCREEN
0;JMP

(WHITE)
@R1
M=0
@SCREEN
D=A
@R0
M=D
@FILL_SCREEN
0;JMP


(FILL_SCREEN)
    //if (D == KBD) goto INF_LOOP
    @R0
    D=M
    @KBD
    D=D-A
    @INF_LOOP
    D;JEQ
    
    @R1
    D=M
    @R0
    A=M
    M=D
    @R0
    M=M+1
@FILL_SCREEN
0;JMP







