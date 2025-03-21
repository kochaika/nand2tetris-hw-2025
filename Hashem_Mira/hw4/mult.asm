// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm


@R2
M=0
(LOOP)
  @R1
  D=M
  @END
  D;JEQ   
  
  @R0
  D=M       
  @R2
  M=M+D     
  
  @R1
  M=M-1     // R1--
  
  @LOOP
  0;JMP     // goto LOOP

(END)

  @END
  0;JMP 