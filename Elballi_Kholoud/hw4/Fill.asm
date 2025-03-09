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
    D = M
    @BLACK
    D;JNE
    @WHITE
    0;JMP
    

    @LOOP
    0;JMP


(WHITE)
    @SCREEN
    D = A
    @8192
    D = D + A 
    @Addr
    M = D

    @SCREEN
    A = A - 1

(LOOP1)
    A = A + 1
    M = 0
    D = A
    @Addr
    D = D - M
    D;JNE
    @LOOP
    0;JMP


(BLACK)
    @SCREEN
    D = A
    @8192
    D = D + A 
    @Addr
    M = D

    @SCREEN
    A = A - 1

(LOOP2)
    A = A + 1
    M = -1
    D = A
    @Addr
    D = D - M
    D;JNE
    @LOOP
    0;JMP
    