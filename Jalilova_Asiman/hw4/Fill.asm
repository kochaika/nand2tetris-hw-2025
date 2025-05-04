// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

 @place // starting point
  M=0 

(LOOP)
  @KBD // take in keyboard value
  D=M 
  @WHITE
  D;JEQ 
  @BLACK
  0;JMP

(WHITE)
  @place
  D=M 
  @LOOP
  D;JLT
  @place
  D=M
  @SCREEN
  A=D+A 
  M=0 
  @place
  M=M-1
  @LOOP
  0;JMP

(BLACK)
  @place
  D=M
  @8192 // max that place can be
  D=D-A
  @LOOP
  D;JGE 
  @place
  D=M
  @SCREEN
  A=D+A
  M=-1
  @place
  M=M+1
  @LOOP
  0;JMP

(END)
  @END
  0;JMP