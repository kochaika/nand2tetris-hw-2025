(LOOP_MAIN)
    @KBD
    D=M

    @FILL
    D;JGT // Any valid keypress has code >= 0

    @CLEAR
    0;JMP

(FILL)
    @8192
    D=A
    @counter
    M=D

    @SCREEN
    D=A
    @current
    M=D

    (LOOP_FILL)
        @counter
        D=M
        @LOOP_MAIN
        D;JEQ

        @current
        A=M
        M=-1
        @current
        M=M+1

        @counter
        M=M-1

        @LOOP_FILL
        0;JMP

(CLEAR)
    @8192
    D=A
    @counter
    M=D

    @SCREEN
    D=A
    @current
    M=D

    (LOOP_CLEAR)
        @counter
        D=M
        @LOOP_MAIN
        D;JEQ

        @current
        A=M
        M=0
        @current
        M=M+1

        @counter
        M=M-1

        @LOOP_CLEAR
        0;JMP
