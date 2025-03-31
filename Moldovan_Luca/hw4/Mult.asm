@2
M=0            //R2=0

@0
D=M            //D=R0               first number

@Mult
M=D            //Mult=R0            mult variable stored in R0

@1
D=M            //D=R1               second number

@count
M=D            //count=R1           count variable stored in R1 (loop counter) 
//we will add the Mult variable to R2 count times

(LOOP)         //int the loop we perform repeated addition which is basically the multiplication
@count 
D=M            //D=count
@END
D;JEQ          //if count == 0 end       like this we ensure that the loop runs only R1 times

@Mult
D=M            //D=R0

@2
M=D+M         //R2 += R0

@count
M=M-1         //decrement loop counter

@LOOP          
0;JMP         //we jump to LOOP to repeat the process until count becomes 0

(END)
@END
0;JMP         //infinite loop




