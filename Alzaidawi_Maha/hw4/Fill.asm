// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed, the screen is filled black.
// When no key is pressed, the screen is cleared (white).

(LOOP)
  @KBD
  D=M
  @WHITE
  D;JEQ
  @BLACK
  0;JMP

// Clear the screen (set all pixels to 0)
(WHITE)
  @0
  D=A
  @place
  M=D            // Reset place to 0
(WHITE_LOOP)
  @place
  D=M
  @8192
  D=D-A
  @LOOP
  D;JGE          // If place >= 8192, go back to LOOP
  @place
  D=M
  @SCREEN
  A=D+A
  M=0            // Set pixel to white
  @place
  M=M+1
  @WHITE_LOOP
  0;JMP

// Fill the screen (set all pixels to -1)
(BLACK)
  @0
  D=A
  @place
  M=D            // Reset place to 0
(BLACK_LOOP)
  @place
  D=M
  @8192
  D=D-A
  @LOOP
  D;JGE          // If place >= 8192, go back to LOOP
  @place
  D=M
  @SCREEN
  A=D+A
  M=-1           // Set pixel to black
  @place
  M=M+1
  @BLACK_LOOP
  0;JMP