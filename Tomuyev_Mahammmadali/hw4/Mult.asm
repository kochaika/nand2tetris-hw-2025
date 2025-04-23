// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

@R2
M=0         // R2 = 0
@R0
D=M
@i
M=D         // i = R0
@R1
D=M
@i
M=M-D       // i = i - R1
D=M
@SWAP
D;JGT       // if i > 0, swap R0, R1
(LOOPSTART)
    @R0
    D=M
    @i
    M=D+1   // i = R0+1
(LOOP)
    @i
    M=M-1   // i = i-1
    D=M
    @END
    D;JEQ   // goto END if i == 0
    @R1
    D=M     // D = R1
    @R2
    M=D+M   // R2 = R2 + R1
    @LOOP
    0;JMP
(END)
    @END
    0;JMP
(SWAP)
    @R0
    D=M     
    @x
    M=D     // x = R0
    @R1
    D=M     
    @R0
    M=D     // R0 = R1
    @x
    D=M     
    @R1
    M=D     // R1 = x
    @LOOPSTART
    0;JMP