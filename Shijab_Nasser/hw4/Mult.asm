// Mult.asm - Simple multiplication using repetitive addition

@R2 
M=0     // Initialize result to 0

@R1
D=M
@END
D;JEQ   // If R1 is 0, result is 0

(LOOP)
    @R0
    D=M
    @R2
    M=D+M  // Add R0 to R2
    
    @R1
    M=M-1  // Decrement counter (R1)
    D=M
    @LOOP
    D;JGT  // Repeat while R1 > 0

(END)
@END
0;JMP   // Infinite loop
@END
0;JMP     // Infinite loop