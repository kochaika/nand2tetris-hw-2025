(Begin)
    @R2
    M=0  //initialise the result to R2=0

    @R1 
    D=M
    @NEGATIVE //check if R1 is negative
    D;JLT

(LOOP)
    @R1
    D=M
    @END
    D;JLE //if R1<=0, then end the loop

    @R0
    D=M
    @R2
    M=D+M

    @R1
    M=M-1
    @LOOP
    0;JMP

(NEGATIVE)
    @R1 
    M=-M
    @R0
    M=-M
    @LOOP
    0;JMP

(END)
    @END
    0;JMP