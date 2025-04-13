// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// 24576 - KEYBOARD, 16384 - SCREEN
// address 0 will hold the screen start position
// address 1 will hold the color of the screen, either 0 or -1
// white or black
(INFLOOP)

// let us start with keyboard check, if zero then white else black

@24576
D=M  // Read the keyboard input
// if zero jump to white
@WHITE
D;JEQ
// else jump to black
@BLACK
0;JMP

(WHITE)
@1
M=0
@CHNGE
0;JMP

(BLACK)
@1
M=-1
@CHNGE
0;JMP

(CHNGE)
// screen start
@16384
D=A
// store current pixel of screen in R0
@0
M=D 

(FILL)
// check color
@1
D=M

@0
// get the address of the pixel to fill
A=M	
// fill it
M=D	

// increment to next pixel
@0
M=M+1	
D=M
// if whole screen is black, restart loop
@24576
D=A-D	//KBD-SCREEN=A
@INFLOOP
D;JEQ 

// else continue filling pixels
@FILL
0;JMP
