// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

@16384 // First Address
D=A
@0 
M=D
@2
M=D

@24575 // Max Adress
D=A
@1
M=D

@24576
D=M
@10
D;JEQ


@2
A=M 
M=!M
@2 
M=M+1
D=M
@1
D=D-M
@14
D;JLE

@24576
D=M
@24
D;JNE

@2
M=M-1

@2
A=M
M=!M
@2 
M=M-1
D=M
@0
D=D-M
@30
D;JGE

@2
M=M+1
@10 
M;JMP
