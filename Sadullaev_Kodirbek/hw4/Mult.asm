@R0
D=M        // get R0

@R2
M=0        // clear R2

@R1
D=M        // get R1
@COUNT
M=D        // set counter

(LOOP)
@COUNT
D=M
@END
D;JEQ      // if 0, end

@R0
D=M
@R2
M=D+M      // add to R2

@COUNT
M=M-1      // dec counter

@LOOP
0;JMP      // loop

(END)
@END
0;JMP
