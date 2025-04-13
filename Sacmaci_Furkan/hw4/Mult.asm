@0
D=A //D = 0
@i
M=D //i = 0 (initialize index)

@R1
D=M //D = value of R1

@R2
M=0 //R2 = 0 initialized

(LOOP)

    @i      
    D=M //D = i (current index)
    @R1
    D=D-M //D = i - R1 (check if we reached the number of elements)
    @LOOPEND
    D;JEQ //If i == R1, exit the loop

    @R0
    D=M //D = base address (R0)
    @R2
    M=D+M //R2 = R2 + value at address R0

    @i
    M=M+1 //index incrementing
  
    @LOOP 
    0;JMP //back to loop

(LOOPEND)
    @R2
    D=M //D = sum (stored in R2)
    @R1
    M=D //Store the sum into R1
    @END_PROGRAM
    0;JMP 

(END_PROGRAM)
    @END_PROGRAM
    0;JMP
