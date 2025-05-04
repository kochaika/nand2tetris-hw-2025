// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.


// multiplication result, initialize to 0
@R2
M=0

// first multiplier
@R0
D=M
@IF_ZERO
D;JEQ

// second multiplier
@R1
D=M
@IF_ZERO
D;JEQ


(START_LOOP)
// counter, end loop when R1=0
    @R1
    D=M
    @END_LOOP
    D;JEQ

// R2=R2+R0
    @R0
    D=M
    @R2
    M=D+M

// decrement R1
    @R1
    M=M-1
    @START_LOOP
    0;JMP

(END_LOOP)
    @END_PROGRAM
    0;JMP


(IF_ZERO) // R2=0 if R0/R1 =0
    @R2
    M=0
    @END_PROGRAM
    0;JMP


(END_PROGRAM)
    @END_PROGRAM
    0;JMP  // call end program recursively to cease operation