// Mult.asm - Efficient multiplication using bitwise operations

@R2
M=0     // Initialize result to 0

(LOOP)
    @R1
    D=M
    @END
    D;JEQ   // Exit if R1 is 0
    
    @R1
    D=M
    @1
    D=D&A   // Check least significant bit
    @SHIFT
    D;JEQ   // If bit is 0, skip addition
    
    @R0
    D=M
    @R2
    M=D+M   // Add R0 to result if bit is set

(SHIFT)
    @R0
    D=M
    M=D+M   // R0 = R0 * 2 (left shift)
    
    // Manual right shift of R1 (divide by 2)
    @R1
    D=M
    @temp
    M=D     // Store original R1 in temp
    
    @R1
    M=0     // Clear R1 for rebuilding
    
    (RSHIFT_LOOP)
        @temp
        D=M
        @LOOP_CONTINUE
        D;JEQ   // Exit when temp is 0
        
        @temp
        M=M-1   // temp--
        D=M
        @temp
        M=M-1   // temp-- again (equivalent to subtracting 2)
        
        @RSHIFT_UPDATE
        D;JLT   // If we went negative, we're done
        
        @R1
        M=M+1   // Increment R1 for each pair we subtracted
        @RSHIFT_LOOP
        0;JMP
        
    (RSHIFT_UPDATE)
        // If we subtracted an odd number, we have 1 left in temp+1
        @temp