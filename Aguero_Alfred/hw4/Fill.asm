// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.
@SCREEN
D=A
@i
M=D

(FILLW)
@i
D=M
@24576
D=D-A
@PRESS
D;JEQ

@i
D=M
A=D
M=-1
@i
M=M+1
@FILLW
0;JMP

(PRESS)
@KBD
D=M
@FILLB
D;JNE

@FILLW
0;JMP

(FILLB)
@SCREEN
D=A
@i
M=D

(LOOPB)
@i
D=M
@24576
D=D-A
@PRESS
D;JEQ

@i
D=M
A=D
M=0

@i
M=M+1
@LOOPB
0;JMP