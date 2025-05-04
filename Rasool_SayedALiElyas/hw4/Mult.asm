// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

(BEGIN)
	// Initialize product to 0.
	@R2
	M=0
(LOOP)
	// If R1 <= 0, terminate.
	@R1
	D=M
	@END
	D;JLE
	// Add R0 to R2.
	@R0
	D=M
	@R2
	M=D+M
	// Decerement R1.
	@R1
	M=M-1
	// Loop.
	@LOOP
	0;JMP
(END)
	// Terminate.
	@END
	0;JMP