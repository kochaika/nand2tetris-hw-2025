// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// Fill.asm - Fills screen on keypress, clears on release  
// (look, I tried to optimize it but idk)

(RESTART)
@SCREEN
D=A          
@0            
M=D

(KBDCHECK)  
  @KBD
  D=M        
  @BLACK
  D;JGT

  @WHITE
  0;JMP      

(BLACK)
@1
M=-1
  @FILL_SCREEN
0;JMP

(WHITE)
  @1        
M=0
  @FILL_SCREEN
0;JMP        

(FILL_SCREEN)  
  @1
    D=M

  @0
A=M
  M=D

  @0
M=M+1

  @KBD        
  D=A
  @0
  D=D-M

  @FILL_SCREEN
  D;JGT

@RESTART      
0;JMP