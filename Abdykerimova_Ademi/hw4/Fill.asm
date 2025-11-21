// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(START)
@KBD
D=M
@FILL
D;JNE
@CLEAR
0;JMP

(FILL)
@SCREEN
D=A
@addr
M=D
@8192
D=A
@count
M=D
(FILL_LOOP)
@0
D=A
D=D-1
@addr
A=M
M=D
@addr
M=M+1
@count
M=M-1
D=M
@FILL_LOOP
D;JGT
@START
0;JMP

(CLEAR)
@SCREEN
D=A
@addr
M=D
@8192
D=A
@count
M=D
(CLEAR_LOOP)
@0
D=A
@addr
A=M
M=D
@addr
M=M+1
@count
M=M-1
D=M
@CLEAR_LOOP
D;JGT
@START
0;JMP
