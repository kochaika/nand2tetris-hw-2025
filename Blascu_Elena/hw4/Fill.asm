// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(LOOP)
    @KBD
    D=M 
    @FILL
    D;JNE

    @SCREEN
    D=A
    @i
    M=D

(CLEAR_LOOP)
    @i
    D=M
    @KBD
    D=D-A
    @END
    D;JGE

    @i
    A=M
    M=0

    @i
    M=M+1    
    @CLEAR_LOOP
    0;JMP

(FILL)
    @SCREEN
    D=A
    @i
    M=D

(FILL_LOOP)
    @i
    D=M
    @KBD
    D=D-A
    @END
    D;JGE

    @i
    A=M
    M=-1

    @i
    M=M+1
    @FILL_LOOP
    0;JMP

(END)
    @LOOP
    0;JMP
