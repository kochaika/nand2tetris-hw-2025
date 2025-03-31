/*
    r0 = 16384
    r1 = 24575
    while (1) {

        if (kbd != 0) {
            // make screen black
            r2 = r0
            while (r2 <= r1) {
                RAM[r2] = 0
                r2 = r2 + 1
            }
        } else {
            make screen white
            for (int i = 16384; i <= 24575; i++) {
                RAM[i] = 0
            }
        }

    }
*/


@16384
D=A
@R0
M=D

@24575
D=A
@R1
M=D

// R0=16384
// R1=24575

(LOOP)

    @KBD
    D=M

    // (IF_BEGIN)
        @ELSE
        D;JEQ

        @R0
        D=M
        @R2
        M=D

        (LOOP2_BEGIN)
            @R2
            D=M
            @R1
            D=D-M
            @LOOP2_END
            D;JGE

            @R2
            A=M    
            M=-1

            @R2
            M=M+1

            @LOOP2_BEGIN
            0;JMP
        (LOOP2_END)


        @IF_END
        0;JMP
    (ELSE)

     @R0
        D=M
        @R2
        M=D

        (LOOP3_BEGIN)
            @R2
            D=M
            @R1
            D=D-M
            @LOOP3_END
            D;JGE

            @R2
            A=M    
            M=0

            @R2
            M=M+1

            @LOOP3_BEGIN
            0;JMP
        (LOOP3_END)


    (IF_END)


    @LOOP
    0;JMP