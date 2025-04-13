// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.


@R2
M=0 // initial ans = 0

@R0
D=M // in D lies value of cell R0
@END
D;JEQ // if = 0, goto @END return 0 (init. before)

@R1
D=M
@END
D;JEQ

(LOOP)
@R1
D=M 
@R2
M=D+M // now increased R2.val by R1.val

@R0
M=M-1 // decrease amount of repetitions
D=M

@LOOP
D;JGT // if D > 0 goto @LOOP

(END)
@END
0;JMP


