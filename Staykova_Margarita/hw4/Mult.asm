// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//// Replace this comment with your code.

// R2=R1*R0
// set the value of the result(selected register-R2) to 0
@R2
M=0          

// select the value of R1 and store it into the D register
@R1
D=M        

// load the address of END and if R1 in the D register is 0,
// the program jumps to the END and stops any other computtaions
@END
D;JEQ     

// store the vale of R0 in D for later usage
@R0
D=M

// save the value of R0 in R3
@R3
M=D   

// beginning of loop
(LOOP)

    // load the value of R3 into the D register
    // so far, R3 contains the original value of R0,
    // so we save it into D for use in subsequent calculations
    @R3
    D=M     

    // add the value of the D register(R0) to the current value in R2
    // and store the result back in R2
    // (basically adding R0 to R2 in each iteration of the loop.)
    @R2
    M=D+M  

    // decrement the the value of R1 by 1
    // we decrease the number of times we will add R0 to R2
    @R1
    M=M-1   

    // in this step we load the value of R1 in the D register
    // to check if it has reached 0 and determine whether 
    // the loop should continue
    @R1
    D=M

    // if the value of D(which is R1) is greater than zero
    // the program jumps back to the loop label
    @LOOP
    D;JGT    

//If R1 is zero at the start, the program would jump here, 
// skipping the loop and finalizing the multiplication.
(END)

// this is an unconditional jump to END. It effectively halts the program, 
// as the program counter jumps to the END label, ending the execution.
@END
0;JMP       
