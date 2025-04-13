/*

if (r0 < 0) {
    r0 = -r0
    r5 = 1 // sign
} else {
    r5 = 0
}

r2 = 0
while (r0 > 0) {
    r3 = 1
    r4 = r1
    while (r3 + r3 <= r0) {
        r3 = r3 + r3
        r4 = r4 + r4
    }    
    r0 = r0 - r3
    r2 = r2 + r4
}

if (r5 == 1) {
    r2 = -r2
}

O(log^2)
*/

@R5
M=0

// (IF_BEGIN)
@R0
D=M
@IF_END
D;JGE
    @R0
    M=-M
    @R5
    M=1
(IF_END)

@R2
M=0

(WHILE_BEGIN)
    @R0
    D=M
    @WHILE_END
    D;JLE

    @R3
    M=1

    @R1
    D=M
    @R4
    M=D

    (WHILE2_BEGIN)
        @R3
        D=M
        D=D+M
        @R0
        D=D-M

        @WHILE2_END
        D;JGE

        @R3
        D=M
        D=D+M
        M=D
        @R4
        D=M
        D=D+M
        M=D

        @WHILE2_BEGIN
        0;JMP
    (WHILE2_END)

    @R0
    D=M
    @R3
    D=D-M
    @R0
    M=D

    @R2
    D=M
    @R4
    D=D+M
    @R2
    M=D

    @WHILE_BEGIN
    0;JMP
(WHILE_END)

// (IF2_BEGIN)
@R5
D=M
@IF2_END
D;JLE
    @R2
    M=-M
(IF2_END)

(END)
    @END
    0;JMP