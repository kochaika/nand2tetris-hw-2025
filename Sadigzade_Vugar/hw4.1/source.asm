
(LOOP_MAIN)
    @KBD
    D=M           
    @FILL
    D;JGT         
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
    @DONE_FILL
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

(DONE_FILL)
    @LOOP_MAIN
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
    @DONE_CLEAR
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

(DONE_CLEAR)
    @LOOP_MAIN
    0;JMP

(counter)  
    @0
    M=0

(current)  
    @0
    M=0
