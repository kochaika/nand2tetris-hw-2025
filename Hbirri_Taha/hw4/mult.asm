@1
D=M
@LOOP_CHECK
D;JEQ

@2
M=0

(LOOP)
    @0
    D=M
    @2
    M=D+M

    @1
    M=M-1
    D=M
    @LOOP
    D;JGT

(END)
@END
0;JMP