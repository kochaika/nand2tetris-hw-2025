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
    @FILL_SCREEN
    D;JNE        

    @CLEAR_SCREEN
    0;JMP        


(FILL_SCREEN)
    @SCREEN
    D=A          
    @addr
    M=D          

(FILL_LOOP)
    @addr
    D=M          
    @KBD
    D=D-A
    @LOOP
    D;JGE        

    @addr
    A=M
    M=-1         

    @addr
    M=M+1        
    @FILL_LOOP
    0;JMP       

(CLEAR_SCREEN)
    @SCREEN
    D=A          
    @addr
    M=D          

(CLEAR_LOOP)
    @addr
    D=M          
    @KBD
    D=D-A
    @LOOP
    D;JGE        

    @addr
    A=M
    M=0          

    @addr
    M=M+1        
    @CLEAR_LOOP
    0;JMP       
