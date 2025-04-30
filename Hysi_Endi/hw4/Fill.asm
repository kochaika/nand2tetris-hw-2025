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

    @COLOR
    M=0         
    @DRAW
    0;JMP       

(FILL)
    @COLOR
    M=-1        

(DRAW)
    @SCREEN
    D=A         
    @8192
    D=D+A       
    @i
    M=D         

(DRAWLOOP)
    @i
    D=M-1
    M=D     
    @LOOP
    D;JLT    
       
    @COLOR
    D=M        
    @i
    A=M         
    M=D       

    @DRAWLOOP
    0;JMP       