// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.
@R2
M=0 // set R2 to 0
@R0
D=M

@SETI
D;JGE

// change the sign in case R0 < 0
@R1
M=-M
@R0
M=-M
D=M

(SETI)
    @i
    M=D // set value of i to R0
(LOOP) // loop for the sum
    @i
    D=M
    @END
    D;JEQ // go to end loop if i == 0
    @R1
    D=M
    @R2
    M=D+M // add 1 more R1 to R2
    @i
    M=M-1
    D=M
    @LOOP
    D;JGT
(END) // end loop
    @END
    0;JMP
