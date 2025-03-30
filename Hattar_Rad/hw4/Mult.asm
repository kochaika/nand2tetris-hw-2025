// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm


// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)


// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm


// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)


(Begin)
    @R2      // Reset R2 to zero
    M=0

(CHECK)
    @R1
    D=M
    @EXIT
    D;JLE    // If R1 is zero or negative, stop

    @R0
    D=M
    @R2
    M=M+D    // Add R0 to R2

    @R1
    M=M-1    // Reduce R1 by 1

    @CHECK
    0;JMP    // Repeat process

(EXIT)
    @EXIT
    0;JMP    // Infinite loop to stop execution
