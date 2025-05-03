// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.
// Fill.asm - Fills the screen black when a key is pressed, clears it otherwise.

(LOOP)
    @KBD
    D=M        
    @BLACK
    D;JNE      
    @c 
    M=0         
    @MAIN
    0;JMP       
(BLACK)
    @c
    M=-1        
(MAIN)
    @SCREEN
    D=A         
    @8192
    D=D+A       
    @i
    M=D         
(PAINT)
    @i
    M=M-1
    D=M    
    @LOOP
    D;JLT     
    @c
    D=M        
    @i
    A=M         
    M=D       
    @PAINT
    0;JMP       