// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.
@SCREEN
 D=A
 @screen
 M=D
 @KBD
 D=A
 @keyboard
 M=D 
(LOOP)
    @keyboard
    D=M
    @LOOP1
    D;JGT
    @LOOP2
    D;JEQ
(LOOP1)
    @SCREEN
    D=A
    @addr
    M=D //addr = screen start
    @8192 
    D=A
    @n
    M=D
    @i
    M=0 // i = 0
    (LOOP1.2)
    @i
    D=M
    @n
    D=D-M
    @LOOP
    D;JGT
    @addr
    A=M
    M=-1
    @i
    M=M+1
    @1
    D=1
    @addr
    M=D+M
    @LOOP1.2
    0;JMP
(LOOP2)
    @SCREEN
    D=A
    @addr
    M=D //addr = screen start
    @8191 
    D=A
    @n
    M=D
    @i
    M=0 // i = 0
    (LOOP2.2)
    @i
    D=M
    @n
    D=D-M
    @LOOP
    D;JGT
    @addr
    A=M
    M=0
    @i
    M=M+1
    @1
    D=1
    @addr
    M=D+M
    @LOOP2.2
    0;JMP