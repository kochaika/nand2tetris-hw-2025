// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.



// Infinite loop that checks keyboard input
(LOOP)
    @KBD
    D=M         // reading keyboard input
    
    @BLACK
    D;JNE    
    @WHITE
    0;JMP   

// blacken the screen, first section run once to reset pixel, then loop afterwards.
// addr is pointer to current pixel being changed, the loop 
(BLACK)
    @SCREEN     // going to first pixel in screen, setting to addr
    D=A
    @addr
    M=D
    
(BLACK_LOOP)
    @addr
    D=M         // getting pixel address, checking if reached end
    @KBD
    D=D-A   
    @LOOP
    D;JGE       // if addr >= KBD, restart checking keyboard
    
    @addr
    A=M         // otherwise, load current address
    M=-1        // set pixel to black (all bits 1)
    
    @addr
    M=M+1       // increment to next pixel and loop again
    
    @BLACK_LOOP
    0;JMP

// subroutine to clear the screen, identical logic to black but setting bit values to 0 instead
(WHITE)
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