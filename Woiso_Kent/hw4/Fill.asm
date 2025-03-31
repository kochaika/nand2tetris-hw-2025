// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.
@g
M=0

(loop)
@KBD
D=M
@screen1
D;JNE
@screen2
0;JMP

(screen1)
@SCREEN
D=A
@fill
0;JMP

(fill)
@i
M=D
A=M
M=-1

@g
M=M+1
D=M

@8192
M=D-M

@fill2
M;JNE
@loop
0;JMP

(fill2)
@i
M=M+1
D=M
@fill
0;JMP

(screen2)
@SCREEN
D=A
@cfill
0;JMP

(cfill)
@i
M=D
A=M
M=-1

@g
M=M+1
D=M

@8192
M=D-M

@cfill2
M;JNE

@loop
0;JMP

(cfill2)
@i
M=M+1
D=M
@cfill
0;JMP

