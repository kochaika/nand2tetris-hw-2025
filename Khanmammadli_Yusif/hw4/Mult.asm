// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

    //i=1
    @i
    M=1
    //sum = 0
    @sum
    M=0
(LOOP)
    //if(i>R0) go to stop
    @i
    D=M
    @R0
    D=D-M
    @STOP
    D;JGT
    @sum
    D=M
    @R1
    D=D+M
    @sum
    M=D
    //i=i+1
    @i
    M=M+1
    @LOOP
    0;JMP
(STOP)
    @sum
    D=M
    @R2
    M=D
//Recommended Infinite loop to avoid malicious attacks.
(END)
    @END
    0;JMP