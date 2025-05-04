// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.
@R2 
M=0 //R2=0
@R1
D=M //D=R1
@AUX
M=D //AUX=R1
//Keep adding R0 to R2 until AUX (which initially is R1) becomes 0
(LOOP)
  @AUX
  D=M
  @END
  D;JEQ //If AUX is 0, jump to END
  @R0
  D=M //D=R0
  @R2
  M=D+M //Add R0 to R2
  @AUX
  M=M-1 //Decrease AUX by 1
  @LOOP
  0;JMP //Jump to LOOP until AUX becomes 0
(END)
  @END
  0;JMP //Infinite END loop 