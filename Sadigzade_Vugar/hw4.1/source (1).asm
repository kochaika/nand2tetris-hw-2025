
@R2
M=0             
@R1
D=M             
@END
D;JEQ           

@counter
M=D            

(LOOP)
    @counter
    D=M
    @DONE
    D;JEQ       
    @R0
    D=M
    @R2
    M=D+M

    @counter
    M=M-1

    @LOOP
    0;JMP


(DONE)
    @END
    0;JMP


(END)
    @END
    0;JMP

