    @2
    M=0     // R2 = 0
    @i
    M=0     // i=0
(LOOP)
    @i
    D=M     // D=i
    @0
    D=D-M   // D=i-R0
    @END
    D;JGE    // if i-R0 >= 0 goto END

    @1
    D=M     // D=R1
    @2
    M=D+M   // R2=R2+R1
    @i
    M=M+1   // i=i+1
    @LOOP
    0;JMP   // Repeat
(END)
    @END
    0;JMP