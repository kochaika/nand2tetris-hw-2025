{\rtf1\ansi\ansicpg1251\cocoartf2821
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 // This file is part of www.nand2tetris.org\
// and the book "The Elements of Computing Systems"\
// by Nisan and Schocken, MIT Press.\
// File name: projects/4/Mult.asm\
\
@R2\
M=0\
@R0\
D=M\
@SETI\
D;JGE\
@R1\
M=-M\
@R0\
M=-M\
D=M\
(SETI)\
    @i\
    M=D\
(LOOP)\
    @i\
    D=M\
    @END\
    D;JEQ\
    @R1\
    D=M\
    @R2\
    M=D+M\
    @i\
    M=M-1\
    D=M\
    @LOOP\
    D;JGT\
(END)\
    @END\
    0;JMP\
}