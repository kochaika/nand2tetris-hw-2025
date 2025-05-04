// tiny update to trigger Git commit
// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.
// Multiplies R0 and R1, stores result in R2
// Uses repeated addition: R2 = R0 × R1 (adds R1 to itself R0 times)

@R2
M=0          // Initialize result to 0
@R0
D=M
@END
D;JEQ        // If R0=0, result is 0
@R1
D=M
@END
D;JEQ        // If R1=0, result is 0
@R0
D=M
@counter
M=D          // counter = R0 value
(LOOP)
@R1
D=M          // Load R1 value
@R2
M=D+M        
@counter
M=M-1        
D=M
@LOOP
D;JGT        // Repeat if counter > 0
(END)
@END
0;JMP        // Infinite loop to terminate