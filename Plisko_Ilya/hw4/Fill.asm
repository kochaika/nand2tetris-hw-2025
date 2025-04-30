// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.
(BEGIN)
@8191
D=A
@n
M=D

@KBD
D=M
@npress
D;JEQ

(cycle1)
@SCREEN
D=A
@n
D=D+M
A=D
M=-1
@n
M=M-1
D=M
@cycle1
D;JGE
@END
0;JMP

(npress)
(cycle2)
@SCREEN
D=A
@n
D=D+M
A=D
M=0
@n
M=M-1
D=M
@cycle2
D;JGE

(END)
@BEGIN
0;JMP

