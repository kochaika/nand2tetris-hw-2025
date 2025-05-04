// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.

(RESTART)
@SCREEN
D=A
@0
M=D	// Store the screen start location in RAM[0]

(KBDCHECK)

@KBD
D=M
@BLACK
D;JGT	// If any keys are pressed, jump to BLACK
@WHITE
D;JEQ	// Else, jump to WHITE

@KBDCHECK
0;JMP	// Loop back to check the keyboard again

(BLACK)
@1
M=-1	// Set screen pixels to black (represented as -1 or 11111111111111)
@CHANGE
0;JMP	// Jump to change the screen pixels

(WHITE)
@1
M=0	// Set screen pixels to white (represented as 0)
@CHANGE
0;JMP	// Jump to change the screen pixels

(CHANGE)
@1	// Get the value to fill the screen with (black or white)
D=M	// D contains black or white value

@0
A=M	// Get the address of the next screen pixel to fill
M=D	// Set the pixel color

@0
D=M+1	// Move to the next pixel
@KBD
D=A-D	// Calculate the difference between KBD and SCREEN addresses

@0
M=M+1	// Increment the screen pixel address
A=M

@CHANGE
D;JGT	// If D is greater than 0, continue changing pixels

@RESTART
0;JMP	// Loop back to restart the process
