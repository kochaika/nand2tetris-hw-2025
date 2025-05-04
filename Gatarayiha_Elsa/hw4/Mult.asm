// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

@0
D=A
@i 
M=D

@1
D=M
@2 
M=0

(LOOP)
@i 
D=M
@1  
D=D-M //setting limits
@END
D;JEQ   //if (i-RAM[1] > 0) goto END
@0    
D=M
@2
M=D+M   //stores the value of RAM[0] to itself
@i
M=M+1  //increase the iteration
@LOOP
0;JMP //repeats the LOOP

(END)
@2
D=M
@1
M=D
@END
0;JMP
