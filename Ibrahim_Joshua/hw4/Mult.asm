// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/mult/Mult.asm

// Mult.asm
// Computes R2 = R0 * R1 using repetitive addition

    @R0
    D=M            // D = R0
    @i
    M=D            // i = R0 (loop counter)

    @R1
    D=M            // D = R1
    @sum
    M=0            // sum = 0

(LOOP)
    @i
    D=M
    @END
    D;JEQ          // if i == 0, goto END

    @R1
    D=M
    @sum
    M=D+M          // sum += R1

    @i
    M=M-1          // i--

    @LOOP
    0;JMP          // goto LOOP

(END)
    @sum
    D=M
    @R2
    M=D            // R2 = sum

(INFINITE_LOOP)
    @INFINITE_LOOP
    0;JMP          // loop forever
