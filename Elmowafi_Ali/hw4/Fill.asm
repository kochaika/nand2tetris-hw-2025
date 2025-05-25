(LOOP)
    @24576
    D=M
    @BLACK
    D;JNE
    @WHITE
    0;JMP

(BLACK)
    @16384
    D=A
    @R13
    M=D

(LOOP_BLACK)
    @R13
    A=M
    M=-1
    @R13
    M=M+1
    D=M
    @24576
    D=D-A
    @LOOP_BLACK
    D;JLT
    @LOOP
    0;JMP

(WHITE)
    @16384
    D=A
    @R13
    M=D

(LOOP_WHITE)
    @R13
    A=M
    M=0
    @R13
    M=M+1
    D=M
    @24576
    D=D-A
    @LOOP_WHITE
    D;JLT
    @LOOP
    0;JMP
