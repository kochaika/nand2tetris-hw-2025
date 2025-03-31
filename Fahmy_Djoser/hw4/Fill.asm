// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// Fill program - Interactive screen fill based on keyboard input

(INIT)
	@8192
	D=A
	@i
	M=D

(LOOP)
	@i
	M=M-1
	D=M
	@INIT
	D;JLT
	@KBD
	D=M
	@WHITE
	D;JEQ
	@BLACK
	0;JMP

(BLACK)             
	@SCREEN
	D=A
	@i
	A=D+M
	M=-1
	@LOOP
	0;JMP

(WHITE)
	@SCREEN
	D=A                
	@i        
	A=D+M
	M=0
	@LOOP
	0;JMP