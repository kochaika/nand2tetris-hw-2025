// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(LOOP)
@24576
D=M
@BLACK
D;JNE
@0
D=A
@R13
M=D
@SET_SCREEN
0;JMP
(BLACK)
@0
D=!A
@R13
M=D
@SET_SCREEN
0;JMP
(SET_SCREEN)
@16384
D=A
@R14
M=D
(SCREEN_LOOP)
@R14
D=M
@24576
D=D-A
@SCREEN_DONE
D;JGE
@R13
D=M
@R14
A=M
M=D
@R14
D=M
D=D+1
@R14
M=D
@SCREEN_LOOP
0;JMP
(SCREEN_DONE)
@LOOP
0;JMP
