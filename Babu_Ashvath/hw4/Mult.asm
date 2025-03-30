// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

//this calls R0
@R0
//asssigns it to the multiplicant
D=M 
//initialises the output
@R2
M=0
//Assigns the multiplier
@R1
//assigns D to R1
D=M 
@END
D;JEQ      

(LOOP)
  @R1     
  D=M      
  @END     

  D;JEQ    
  @R0  
  D=M 
  // Add R0 to R2
  @R2 
  // R2 = R2 + R0
  M=D+M    
  //code to decrement the valye r1 by 1
  @R1  
  M=M-1 
  @LOOP 
  0;JMP    

(END)
  // Infinite loop to stop execution
  @END 
  0;JMP
