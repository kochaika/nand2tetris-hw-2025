// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.
// Label for the start of the program
(START)
    @KBD
    D=M        // Read the keyboard input
    @DRAW_WHITE
    D;JEQ      // If no key is pressed (D == 0), jump to DRAW_WHITE

// If a key is pressed, fill the screen with black
(DRAW_BLACK)
    @SCREEN
    D=A
    @ADDR
    M=D        // Initialize ADDR to point to SCREEN memory

(LOOP_BLACK)
    @ADDR
    D=M        // Load the current address
    @KBD
    D=D-A
    @START
    D;JGE      // If we've reached the end of the screen memory, restart

    @ADDR
    A=M        // Set the address
    M=-1       // Set the pixel to black (all 1s)

    @ADDR
    M=M+1      // Move to the next pixel
    @LOOP_BLACK
    0;JMP      // Repeat until the screen is filled

// If no key is pressed, clear the screen (set all pixels to white)
(DRAW_WHITE)
    @SCREEN
    D=A
    @ADDR
    M=D        // Initialize ADDR to point to SCREEN memory

(LOOP_WHITE)
    @ADDR
    D=M        // Load the current address
    @KBD
    D=D-A
    @START
    D;JGE      // If we've reached the end of the screen memory, restart

    @ADDR
    A=M        // Set the address
    M=0        // Set the pixel to white (all 0s)

    @ADDR
    M=M+1      // Move to the next pixel
    @LOOP_WHITE
    0;JMP      // Repeat until the screen is cleared
