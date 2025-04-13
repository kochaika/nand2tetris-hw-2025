// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//start
@R2
//memory location(RAM[2])
M=0
//set RAM[2] = 0

@R1
//select RAM[1]
D=M
//store the value of RAM[1] in register D
@END
//if RAM[1] == 0, the program finishes
D;JEQ
//jumi if D(the value in D-register) is equal to 0

//moltiplication
(LOOP)
//marking the start of our loop
@R1
D=M
//store its value in D
@END
//if R1==0 we are done
D;JEQ
//Jump to the END if R1 is equal to 0

@R0
D=M
//store its value in D(D = RAM[0])

@R2 
M=D+M
//add D(R0) to M(R2)     


@R1
M=M-1
//decreased RAM[1] by 1

@LOOP
//go back to the start of the loop
0;JMP
//jump to loop

//part 3 end of program
(END)
@END
0;JMP
//jump to (END)/itself forever to stop execution
