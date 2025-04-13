// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

  @place // starting point
  M=0 // place at upper left corner

(LOOP)
  @KBD // take in keyboard value
  D=M // put it into D
  @WHITE
  D;JEQ // if keyboard value == 0 (aka not pressed) goto WHITE
  @BLACK
  0;JMP // otherwise, goto BLACK

(WHITE)
  @place
  D=M // put place into D
  @LOOP
  D;JLT // jump to LOOP if we are at less than minimum (0)
  @place
  D=M
  @SCREEN
  A=D+A // calculate place in the screen
  M=0 // fill pixel with white
  @place
  M=M-1 // decrease place
  @LOOP
  0;JMP // jump to LOOP

(BLACK)
  @place
  D=M
  @8192 // max that place can be
  D=D-A
  @LOOP
  D;JGE // jump to LOOP if we are at the max (place - 8192 >= 0)
  @place
  D=M
  @SCREEN
  A=D+A // calculate place
  M=-1 // fill black
  @place
  M=M+1 // increase place by 1
  @LOOP
  0;JMP //go back to LOOP

(END)
  @END
  0;JMP // Infinite loop at end