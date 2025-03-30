; Fill.asm - Interactive Program
.data
    prompt: .asciiz "Enter a character: "
    newline: .asciiz "\n"
    buffer: .space 11  # Space for 10 characters + null terminator

.text
    .globl main

main:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read a character
    li $v0, 12
    syscall
    move $t0, $v0  # Store the character in $t0

    # Fill the buffer with the character
    la $t1, buffer  # Load buffer address
    li $t2, 10      # Loop counter

fill_loop:
    sb $t0, 0($t1)  # Store character in buffer
    addi $t1, $t1, 1  # Move to next position
    subi $t2, $t2, 1  # Decrease counter
    bgtz $t2, fill_loop  # Loop if counter > 0

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Print filled buffer
    li $v0, 4
    la $a0, buffer
    syscall

    # Exit
    li $v0, 10
    syscall
