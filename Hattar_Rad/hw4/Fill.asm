// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.



(WAIT)
    @KBD
    D=M        // Read keyboard state

    @BLACK
    D;JNE      // If a key is pressed, switch to black
    @WHITE
    0;JMP      // Otherwise, switch to white

(Black)
    @SCREEN
    D=A
    @pos
    M=D        // Start at screen's first address

(Black_LOOP)
    @pos
    D=M
    @KBD
    D=D-A
    @WAIT
    D;JGE      // If reached keyboard, restart

    @pos
    A=M
    M=-1       // Color pixel black

    @pos
    M=M+1      // Move to next pixel

    @BLACK_LOOP
    0;JMP      // Continue filling

(White)
    @SCREEN
    D=A
    @pos
    M=D        // Start at screen's first address

(White_LOOP)
    @pos
    D=M
    @KBD
    D=D-A
    @WAIT
    D;JGE      // If reached keyboard, restart

    @pos
    A=M
    M=0        // Reset pixel to white

    @pos
    M=M+1      // Move to next pixel

    @WHITE_LOOP
    0;JMP      // Continue clearing

