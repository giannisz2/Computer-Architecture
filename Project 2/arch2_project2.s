.org 0x80020000
.text
.globl main

main:
    la $s1, matrix1
    la $s2, matrix2
    la $s3, matrix3

    li $t7, 16
    li $s4, 0 # initialize counter of the specific number we are tracking
    li $s5, 0
    li $s6, 0
    li $s7, 0
    li $v0, 0

loop1:              beq $s5, $t7, exit
loop2:              beq $s6, $t7, change_line
loop3:              beq $s7, $t7, change_element

                    lw $t1, 0($s1) 
                    lw $t2, 0($s2)
                    mul $t3, $t1, $t2
                    
                    
                    # overflow checking
                    srl $t5, $t3, 31 # check first bit to see if number is positive or negative
                    srl $t6, $t4, 31 
                    xor $t6, $t6, $t3 # check if the two first bits are the same

                    add $t4, $t4, $t3 # sum of multiplication process

                    bne $t6, $v0, continue1 # if they are not, no way for overflow, so continue
                    srl $t3, $t4, 31
                    bne $t5, $t3, exit # else check first bit of new sum and first bit of number we are adding
                   

continue1:          addi $s1, $s1, 4 # next element in row
                    addi $s2, $s2, 64 # next element in column (4*16 to change column)
                    addi $s7, $s7, 1 # counter of elements += 1

                    j loop3

change_element:     sw $t4, 0($s3) # store c[i][j] to 3rd matrix

                    addi $s1, $s1, -64 # reset index to the start of the row

                    # reset index to the start of column + 1 so we can start
                    # doing the same job in the second column
                    addi $s2, $s2, -1020

                    addi $s6, $s6, 1 # next column counter
                    
                    li $s7, 0 # reset counter of elements 

                
                    addi $s3, $s3, 4  # next cell of 3rd matrix

                    li $t4, 0 # reset the sum

                    j loop2

change_line:        addi $s1, $s1, 64 # next row
                   	la $s2, matrix2 # reset column
                    li $s6, 0 # reset counter of columns
                    addi $s5, $s5, 1 # increase counter of rows
                    j loop1



exit:      		    li $t5, 9785 # number we are tracking
                    la $s3, matrix3 # reset address of matrix3
                    li $t7, 256 # times we are looping the 3rd matrix
                    li $s0, 0 # counter

                    # check for number that we are tracking
check_n:            beq $s0, $t7, exit_code
                    lw $s1, 0($s3)
                    bne $s1, $t5, continue3
                    addi $s4, $s4, 1

continue3:          addi $s3, $s3, 4
                    addi $s0, $s0, 1
                    j check_n      

exit_code:  li $v0, 10
            syscall

.data
.org 0x10000000

matrix1: .word -40, 24, 12, -51, -14, 42, -49, 30, 17, 45, 12, -14, 28, 11, -40, -48, 42, 32, -3, 6, -17, -19, -48, 33, -42, 27, 29, -31, -53, 9, 43, -61, -35, -45, -62, -36, 27, 30, 23, 31, 40, 42, -58, 1, -57, 43, -10, -37, 39, -36, -13, -29, -26, -32, 22, -59, 63, -5, -31, 0, 13, -34, -39, 22, -52, 27, 4, -54, 22, -57, 41, -7, 31, 25, -22,-11, -15, 7, 34, -17, -18, 16, -21, -27, -39, -7, 38, 41, -2, 17, 25, 39, -33, -36, -51, -23, 6, 41, -55, 10, 54, 33, 50, 40, 49, -58, 11, -55, -44, -16, -45, -28, 40, -52, 8, -25, 49, -45, -39, -53, -48, 22, 58, 55, -33,-49, 51, -38, 52, -59, 1, -49, -16, -19, -19, -9, -46, -8, -34, 5, 11, -2, -24, -38, -51, 10, -14, -12, 58, 49, -8, 39, 48, -41, 57, 27, 63, 27, -45, 36, 6, -24, -50, -56, 17, 15, -14, 57, -16, -38, 33, -37, 30, 58, 39, -48, 14, 25, 28, 53, -54, -30, 40, 60, 24, -61, 43, -31, -58, 60, -1, 60, -34, -63, 26, -51, 39, -3, 20, 41, 13, 39, -19, 25, -23, -57, -26, 35, -60, -22, -54, -38, 10, -3, -40, -15, 41, -2, -40, -63, -6, 44, 61, 46, 49, 37, 54, 10, -16, 42, 6, -3, 61, 48, -20, 12, 29, -49, -11, -55, -56, 40, 8, -23, -41, -49, -23, 20, 45, -7, 11, -31, 58, 53, -31, -35
matrix2: .word -34, 4, 59, -42, 49, 53, 11, 63, 7, 61, 7, -49, 54, -63, 58, 48, -47, -13, 2, -63, 21, 48, -6, -19, 33, -38, 31, 56, -43, -27, 34, -60, -10, 25, -17, 61, 26, 56, 59, 45, -24, 31, -33, 15, -46, -29, 44, -54, -64, -57, 56, 17, -7, 4, 42, -28, 29, 42, 2, -22, -38, -23, -1, -40, -38, -33, 40, -29, -19, 60, -42, 3, -33, -46, -63, -12, 7, 48, 51, -57, 22, 63, 58, 36, 48, -14, 50, -53, 42, -30, -19, 23, 38, 37, -32, 34, -58, 3, -5, 38, 28, 17, 3, -3, 13, -59, -5, 41, 38, -61, 19, -21, 63, 2, -57, 21, 40, -1, 20, 8, -12, 58, -6, 9, -11, -44, -63, 62, -61, -4, -7, 49, -20, -53, -2, 34, -46, 52, 17, 19, -17, -56, 10, 46, 55, 40, 49, -51, -56, -53, 26, -43, -23, 32, -5, 11, -44, -12, -2, 39, -34, 19, -42, 61, -6, -6, 17, 60, -22, -49, 24, -61, -13, -32, -18, -3, -16, 49, -61, -10, 23, -56, 18, 4, -31, -53, 54, 6, 32, -47, -2, -64, -8, 8, -52, -26, -23, 46, 6, -41, -33, -16, 11, 25, -43, -60, -61, 56, -43, 31, -7, -35, 17, -56, -19, -47, -2, -46, 19, 27, 52, 62, -33, 50, -18, 7, 7, 15, 16, 16, -25, -19, -20, -17, 54, 0, -13, -1, 56, -7, 22, -54, 47, -27, 42, 52, 20, 35, 30, 43, 39, -12, 28, -44, 24, 21 
matrix3: .space 1024
