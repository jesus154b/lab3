.text
# Text segment
        .globl _start;
_start: # entry point
        li      a1, 10;
        j arraysum

.section .text
.global arraysum

arraysum:
    # a0 = int a[]
    # a1 = int size
    # t0 = ret
    # t1 = i
    addi  t0, zero, 0  # ret = 0
    addi  t1, zero, 0  # i = 0
1:  # For loop
    bge   t1, a1, 1f   # if i >= size, break
    slli  t2, t1, 2    # Multiply i by 4 (1 << 2 = 4)
    add   t2, a0, t2   # Update memory address
    lw    t2, 0(t2)    # Dereference address to get integer
    add   t0, t0, t2   # Add integer value to ret
    addi  t1, t1, 1    # Increment the iterator
    jal   zero, 1b     # Jump back to start of loop (1 backwards)
1:
    addi  a0, t0, 0    # Move t0 (ret) into a0
    jalr  zero, 0(ra)  # Return via return address register

more:
   .align 8 
   addi x3,x0,0    # i = 0
   addi x4,x0,30   # const 30
loop:
   bge  x3,x4, exit
   addi x3,x3,1
   j loop

exit:
    li      a0, 0;  # set exit value to 0
    li      a7, 93; # set syscall to `exit`
    ecall;


        .section ".tohost","aw",@progbits
        .globl tohost
        .globl fromhost

        .align 6
tohost: .dword 0
        .align 6
fromhost: .dword 0