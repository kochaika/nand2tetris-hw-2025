@0
D=M        
@i
M=D       

@sum
M=0       

(LOOP)
    @i
    D=M
    @END
    D;JEQ

    @1
    D=M    
    @sum
    M=D+M

    @i
    MD=M-1
    @LOOP
    D;JGT

(END)
    @sum
    D=M
    @2
    M=D    

(ENDLOOP)
    @ENDLOOP
    0;JMP