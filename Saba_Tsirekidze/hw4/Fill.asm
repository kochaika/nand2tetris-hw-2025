(LOOP1)

@KBD
D=M
@WHITE
D;JEQ

@KBD
D=M
@BLACK
D;JNE

@LOOP1
0;JMP

(BLACK)

    @8191
    D=A
    @R0
    M=D

    (LOOP2)

        @R0
        D=M
        @LOOP1
        D;JLT

        @R0
        D=M
        @SCREEN
        A=D+A
        M=-1

        @R0
        M=M-1

        @LOOP2
        0;JMP

(WHITE)

    @8191
    D=A
    @R0
    M=D

    (LOOP3)

        @R0
        D=M
        @LOOP1
        D;JLT

        @R0
        D=M
        @SCREEN
        A=D+A
        M=0

        @R0
        M=M-1

        @LOOP3
        0;JMP

