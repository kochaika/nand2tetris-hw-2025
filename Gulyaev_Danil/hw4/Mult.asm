(BEGIN)
    @R2
    M=0
    @R1
    D=M
    @R3
    M=D

(LOOP)
    @R3
    D=M
    @END
    D;JLE
    @R0
    D=M
    @R2
    M=D+M
    @R3
    M=M-1
    @LOOP
    0;JMP

(END)
    @END
    0;JMP
