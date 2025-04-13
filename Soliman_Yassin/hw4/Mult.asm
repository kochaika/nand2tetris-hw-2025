// Mult.asm - multiplies R0 and R1 and stores the result in R2
@R2
M=0          // Clear R2

@R0
D=M
@R3
M=D          // R3 = counter

(LOOP)
@R3
D=M
@END
D;JLE        // If counter <= 0, end

@R2
D=M
@R1
D=D+M
@R2
M=D          // R2 += R1

@R3
M=M-1        // Decrement counter
@LOOP
0;JMP

(END)
@END
0;JMP
