// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

//// Replace this comment with your code.
(PRESS)
@KBD
D=M //D gets the value of the key pressed
@WHITE
D;JEQ //If D is 0 (no key pressed), then the screen is white

// Make entire screen black
@SCREEN
D=A
@CNT
M=D //CNT used for going through all the pixels
(LOOP_BLACK)
  @CNT
  D=M
  @24576
  D=D-A //Check if we already went through all the pixels
  @PRESS
  D;JEQ //Jump back to the beginning if we already set all the pixels to black
  @CNT
  D=M //Take value of CNT
  A=D //Go to the adress represented by the value
  M=-1 //Set the pixel to black
  @CNT
  M=M+1 //Increase CNT
  @LOOP_BLACK
  0;JMP

// Make entire screen white (similar to the black)
(WHITE)
@SCREEN
D=A
@CNT
M=D //CNT used for going through all t he pixels
(LOOP_WHITE)
  @CNT
  D=M
  @24576
  D=D-A //Check if we already went thoguh all the pixels
  @PRESS
  D;JEQ //Jump back to beginning if we already set all the pixels to white
  @CNT
  D=M //Take value of CNT
  A=D //Go to the adress represented by the value
  M=0 //Set the pixel to white
  @CNT
  M=M+1 //Increase CNT
  @LOOP_WHITE
  0;JMP