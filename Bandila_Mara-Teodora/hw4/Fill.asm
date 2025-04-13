// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(RESTART)
@SCREEN
D=A
@0
M=D	// Putting start location in R0

(KBDCHECK)

@KBD
D=M
@BLACK
D;JGT	// If any key is pressed jump and fill screen
@WHITE
D;JEQ	// Else make screen blank

@KBDCHECK
0;JMP

(BLACK)
@1
M=-1	// Fill screen (-1 in binary is 11111111111111)
@CHANGE
0;JMP

(WHITE)
@1
M=0	// Fill screen (00000000000000)
@CHANGE
0;JMP

(CHANGE)
@1
D=M	// D is either full or blank

@0
A=M	// Get address of pixel to be filled
M=D	// then fill

@0
D=M+1	// Next pixel
@KBD
D=A-D	//KBD-SCREEN=A

@0
M=M+1	// Increment to next pixel
A=M

@CHANGE
D;JGT	// If A=0 screen is black therefore exit

@RESTART
0;JMP
