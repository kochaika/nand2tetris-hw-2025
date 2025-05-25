@2
M=0

(LOOP)
    @1
    D=M
    @END
    D;JEQ

    @0
    D=M
    @2
    M=D+M

    @1
    M=M-1

@LOOP
0;JMP

(END)
0;JMP