// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.

(BEGIN)
			// initialize product to 0.
	@R2
	M=0
(LOOP)
			// if R1 <= 0, exit as we are done.
	@R1
	D=M
	@END
	D;JLE
			// add R0 to R2.
	@R0
	D=M
	@R2
	M=D+M


	@R1		// decrement R1 and loop until R1 is 0
	M=M-1
	@LOOP
	0;JMP

(END)
	@END
	0;JMP