(LOOP)
    @24576
    D=M        
    @WHITE
    D;JEQ

(BLACK)
    @SCREEN
    D=A
    @addr
    M=D        

    @8192
    D=A
    @count
    M=D        

(BLACK_LOOP)
    @addr
    A=M
    M=-1

    @addr
    M=M+1      
    @count
    MD=M-1     
    @BLACK_LOOP
    D;JGT

    @LOOP
    0;JMP

(WHITE)
    @SCREEN
    D=A
    @addr
    M=D

    @8192
    D=A
    @count
    M=D

(WHITE_LOOP)
    @addr
    A=M
    M=0

    @addr
    M=M+1
    @count
    MD=M-1
    @WHITE_LOOP
    D;JGT

    @LOOP
    0;JMP
