@R2
M=0 // Result = 0

@R1
D=M
@END
D;JEQ // Jump to END if first operand is 0

@counter
M=D

(LOOP)
    @counter
    D=M
    @END
    D;JEQ // Jump to END if second operand is 0

    @R0
    D=M
    @R2
    M=D+M // Repeat Addition

    @counter
    M=M-1 // Repeat LOOP 1 less time

    @LOOP
    0;JMP

(END)
