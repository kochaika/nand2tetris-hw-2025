// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

// Put your code here.

@2	//GO TO FINAL ANSWER BOX
M=0	//ZERO ANS BOX

@0
D=M
@END
D;JEQ	//IF ONE PRODUCT IS ZERO

@1
D=M
@END
D;JEQ	//IF ONE PRODUCT IS ZERO

@0	//NOT NECESSARY
D=M	//
@3	//
M=D	//ONLY TO KEEP THE NUMBERS BEING MUTLIPLED


(LOOP)
@1	//GET 2ND NUM
D=M	//D HAS 2ND NUM

@2	//GO TO FINAL ANSWER BOX
M=D+M	//RAM[2] NOW HAS 2ND NUMBER + ITS PREVIOUS VALUE

@3	//GET 1ST NUM
M=M-1	//1ST NUM-1

D=M	//IDK WHY D NEEDS TO =M?
@LOOP	//WHERE TO JUMP TO
D;JGT	//JUMP		    (WHY CANT THIS BE M;JGT?)


(END)
@END
0;JMP	//FOREVER LOOP