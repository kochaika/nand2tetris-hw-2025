// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.
//PART 1: INITIALIZATION
@R2
//select memory location(RAM[2])
M=0
//set RAM[2] = 0

@R1
//select RAM[1]
D=M
//store the value of RAM[1] in register D
@END
//if RAM[1] == 0, we don t need to do anything
D;JEQ
//jumi if D(the value in D-register) is EQual to 0

//part 2 : loop setup(we will repeatedly add R0 in R2 while continuously decreasing R1
(LOOP)
//marking the start of our loop
@R1
D=M
//store its value in D
@END
//if R1==0 we are done
D;JEQ
//Jump to the END if R1 is EQual to 0

@R0
D=M
//store its value in D(D = RAM[0]

@R2 
M=D+M
//add D(R0) to M(R2)     


@R1
M=M-1
//we decrease RAM[1] by 1

@LOOP
//go back to the start of the loop
0;JMP
//jump to loop

//part 3 end Program
(END)
//this marks the end of the program
@END
0;JMP
//jump to (END)/itself forever to stop execution
