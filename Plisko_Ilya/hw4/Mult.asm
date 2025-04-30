// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.

@R2
M=0
@R3
M=1

(CYCLE)
@R3
D=M
@32767
A=A+1
D=D-A
@END
D;JEQ

@R1
D=M
@R3
D=D&M
@PASS
D;JEQ
@R0
D=M
@R2
M=D+M

(PASS)
@R0
D=M
M=D+M
@R3
D=M
M=D+M
@CYCLE
0;JMP

(END)
@END
0;JMP



