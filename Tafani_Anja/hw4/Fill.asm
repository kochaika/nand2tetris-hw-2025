// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.


// address of screen, store it in SCREEN for easier use
@16384
D=A
@SCREEN
M=D

// address of keyboard keys, store it in KBD for easier use
@24576
D=A
@KBD
M=D


(WHITE)
    @KBD
    D=M  // D=key pressed
    @BLACK
    D;JNE  // if D != 0 (key's pressed), jump to BLACK

// clear SCREEN if D=0
    @SCREEN
    D=A  // A -> SCREEN
    @I
    M=D  // I -> A to iterate

    (WHITEN)
        @I
        A=M  // A=I
        M=0  // clear current screen location
        @I
        M=M+1   // increment address pointer

        // last screen memory address
        @24575
        D=A
        @I
        A=M-D   // check if I -> end of screen
        @WHITEN
// when I has reached or surpassed end of screen, the result M-D will be 0 or positive
        D;JLT   // if not, loop again (JLT=jump if less than)

// repeat loop whenever a key is pressed/ let go of
    @WHITE
    0;JMP

(BLACK)
    @SCREEN
    D=A
    @I
    M=D

    (BLACKEN)
        @I
        A=M  // A -> I (current screen address)
        M=-1    // current screen location -> black (-1=1111...)
        @I
        M=M+1

        @24575
        D=A
        @I
        A=M-D
        @BLACKEN
        D;JLT   // if not at end, loop again

    @WHITE
    0;JMP  // repeat