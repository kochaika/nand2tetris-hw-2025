// Mult.asm

    @R2
    M=0     //  R2 = 0

(LOOP)
    @R1
    D=M     // D = R1
    @END
    D;JLE   // If R1 <= 0, goto END
    
    @R0
    D=M     // D = R0
    @R2
    M=D+M   // R2 = R2 + R0
    
    @R1
    M=M-1   // R1 = R1 - 1
    
    @LOOP
    0;JMP   // Repeating the loop

(END)
    @END
    0;JMP   // Infinte loop for ending program