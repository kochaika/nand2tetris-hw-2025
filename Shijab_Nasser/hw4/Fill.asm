// Fill.asm - Fills memory starting from RAM[10] with numbers (until 0)

@10    // Starting address for array
D=A    // Load RAM[10] address into D
@i     // Store base address into i
M=D    // Save base address to i

(LOOP)
    @i
    D=M   // Load current index (i)
    @0    // Load user input value (we simulate this with preloaded values)
    D=M   // Load value to be inserted
    @END
    D;JEQ // Exit loop if the value is 0

    @i
    A=M   // Set address to current index
    M=D   // Store input value

    @i
    M=M+1 // Increment index (move to the next memory address)
    @LOOP
    0;JMP // Repeat loop

(END)
@END
0;JMP  // Infinite loop