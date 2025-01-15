.org 0x80020000
.text
.globl main
main:
    li $ra, 0
    li $s0, 16 # n dimension
    li $t0, 4 # block size
    li $s1, 0 # ii
    li $s2, 0 # jj
    li $s3, 0 # kk
    li $t1, 0 # i
    li $t2, 0 # j
    li $t3, 0 # k
   

    la $t7, matrix1
    la $s7, matrix2
    la $t6, matrix3

loop1:  beq $s1, $s0, continue1
            add $s1, $s1, $t0
loop2:      beq $s2, $s0, continue2
                 add $s2, $s2, $t0
loop3:          beq $s3, $s0, continue3
                    add $s3, $s3, $t0
loop4:              beq $t1, $s1, continue4
                       
loop5:                  beq $t2, $s2, continue5
                            
loop6:                      beq $t3, $s3, continue6
                                


                                mul $v0, $t1, 64 # v0 = i
                                mul $v1, $t2, 4 # v1 = j
                                la $t6, matrix3
                                add $sp, $v0, $v1
                                add $t6, $t6, $sp

                                mul $ra, $t3, 4
                                la $t7, matrix1
                                add $sp, $v0, $ra # ra = M1[i,k]
                                add $t7, $t7, $sp
                                lw $s6, 0($t7)

                                mul $ra, $ra, 16
                                la $s7, matrix2
                                add $sp, $v1, $ra # ra = M2[i,k]
                                add $s7, $s7, $sp
                                lw $s5, 0($s7)

                                mul $t5, $s6, $s5
                                add $t4, $t4, $t5

                                addi $t3, $t3, 1
                                j loop6
                        
continue6:                  sw $t4, 0($t6)

                            li $v0, 1
                            move $a0, $t4
                            syscall

                            addi $t2, $t2, 1
                            
                            li $t4, 0 # reset sum

                            addi $t2, $t2, 1
                            j loop5

continue5:                   addi $t1, $t1, 1
                            j loop4

continue4:              add $t3, $s3, $zero
                       
                        j loop3

continue3:              add $t2, $s2, $zero
                        add $s2, $s2, $t0
                        j loop2

continue2:              add $t1, $s1, $zero
                        add $s1, $s1, $t0
                        j loop1

continue1:          li $v0, 10
                    syscall

.data
.org 0x10000000

matrix1: .word -40, 24, 12, -51, -14, 42, -49, 30, 17, 45, 12, -14, 28, 11, -40, -48, 42, 32, -3, 6, -17, -19, -48, 33, -42, 27, 29, -31, -53, 9, 43, -61, -35, -45, -62, -36, 27, 30, 23, 31, 40, 42, -58, 1, -57, 43, -10, -37, 39, -36, -13, -29, -26, -32, 22, -59, 63, -5, -31, 0, 13, -34, -39, 22, -52, 27, 4, -54, 22, -57, 41, -7, 31, 25, -22,-11, -15, 7, 34, -17, -18, 16, -21, -27, -39, -7, 38, 41, -2, 17, 25, 39, -33, -36, -51, -23, 6, 41, -55, 10, 54, 33, 50, 40, 49, -58, 11, -55, -44, -16, -45, -28, 40, -52, 8, -25, 49, -45, -39, -53, -48, 22, 58, 55, -33,-49, 51, -38, 52, -59, 1, -49, -16, -19, -19, -9, -46, -8, -34, 5, 11, -2, -24, -38, -51, 10, -14, -12, 58, 49, -8, 39, 48, -41, 57, 27, 63, 27, -45, 36, 6, -24, -50, -56, 17, 15, -14, 57, -16, -38, 33, -37, 30, 58, 39, -48, 14, 25, 28, 53, -54, -30, 40, 60, 24, -61, 43, -31, -58, 60, -1, 60, -34, -63, 26, -51, 39, -3, 20, 41, 13, 39, -19, 25, -23, -57, -26, 35, -60, -22, -54, -38, 10, -3, -40, -15, 41, -2, -40, -63, -6, 44, 61, 46, 49, 37, 54, 10, -16, 42, 6, -3, 61, 48, -20, 12, 29, -49, -11, -55, -56, 40, 8, -23, -41, -49, -23, 20, 45, -7, 11, -31, 58, 53, -31, -35
matrix2: .word -34, 4, 59, -42, 49, 53, 11, 63, 7, 61, 7, -49, 54, -63, 58, 48, -47, -13, 2, -63, 21, 48, -6, -19, 33, -38, 31, 56, -43, -27, 34, -60, -10, 25, -17, 61, 26, 56, 59, 45, -24, 31, -33, 15, -46, -29, 44, -54, -64, -57, 56, 17, -7, 4, 42, -28, 29, 42, 2, -22, -38, -23, -1, -40, -38, -33, 40, -29, -19, 60, -42, 3, -33, -46, -63, -12, 7, 48, 51, -57, 22, 63, 58, 36, 48, -14, 50, -53, 42, -30, -19, 23, 38, 37, -32, 34, -58, 3, -5, 38, 28, 17, 3, -3, 13, -59, -5, 41, 38, -61, 19, -21, 63, 2, -57, 21, 40, -1, 20, 8, -12, 58, -6, 9, -11, -44, -63, 62, -61, -4, -7, 49, -20, -53, -2, 34, -46, 52, 17, 19, -17, -56, 10, 46, 55, 40, 49, -51, -56, -53, 26, -43, -23, 32, -5, 11, -44, -12, -2, 39, -34, 19, -42, 61, -6, -6, 17, 60, -22, -49, 24, -61, -13, -32, -18, -3, -16, 49, -61, -10, 23, -56, 18, 4, -31, -53, 54, 6, 32, -47, -2, -64, -8, 8, -52, -26, -23, 46, 6, -41, -33, -16, 11, 25, -43, -60, -61, 56, -43, 31, -7, -35, 17, -56, -19, -47, -2, -46, 19, 27, 52, 62, -33, 50, -18, 7, 7, 15, 16, 16, -25, -19, -20, -17, 54, 0, -13, -1, 56, -7, 22, -54, 47, -27, 42, 52, 20, 35, 30, 43, 39, -12, 28, -44, 24, 21
matrix3: .space 1024
