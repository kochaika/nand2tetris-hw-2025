(LOOP)
    @1
    D=1
    @24576
    M=D-M
    
    @8191
    D=A
    @count
    M=D
    @SCREEN
    D=A
    @addr
    M=D

    @KBD
    D=M
    
    @BLACK_SCREEN
    D;JNE

    @WHITE_SCREEN
    0;JMP

(BLACK_SCREEN)
    @addr
    A=M
    M=-1

    @addr
    M=M+1

    @count
    M=M-1
    D=M
    @BLACK_SCREEN
    D;JGT
    @LOOP
    0;JMP

(WHITE_SCREEN)
    @addr
    A=M
    M=0

    @addr
    M=M+1

    @count
    M=M-1
    D=M
    @WHITE_SCREEN
    D;JGT
    @LOOP
    0;JMP
