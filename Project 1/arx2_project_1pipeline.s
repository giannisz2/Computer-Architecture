.org 0x80020000
	.text 
	.globl main
main:

				li $s0, 52			# load to $s0 the array size
				la $t0, array			# load to $t0 address of array
				add $s3, $zero, $zero 	# initialize $s3, counter for 0's
				add $s4, $zero, $zero	# initialize $s4, counter for even numbers
				lw $s1, 0($t0)	        # initial max is array[0]  $s1 == max
				lw $s2, 0($t0)	        # initial min is array[0]  $s2 == min

				# counters for project requests
				
				add $s5, $zero, $zero	# initialize $s5, counter for odd numbers
				add $s6, $zero, $zero	# initialize $s6, counter for numbers that are devided by 3
				add $s7, $zero, $zero	# initialize $s7, counter for numbers that are devided by 5






main_loop:		beq $s0, $zero, exit_program	# main loop if( $s0 == 0)then exit ftom main loop (initial $s0 == size of array)
				lw $t7, 0($t0)	    		# $t7 has the elements of array in every loop
				li $t3, 3			# we earn cycles 
				slt $t5, $s1, $t7	# we earn cycles 
				div $t7, $t3		# we earn cycles 
				li $t4, 5			# we earn cycles 
				slt $t6, $t7, $s2	# we earn cycles 
				mfhi $t3			# we earn cycles 

#---------------  count of zero, max, min, odd, even, div3 and div5 check element of list -----------------------------------------------#

				
				beq $t5, $zero, not_bigger		# max	
				add $s1, $t7, $zero 

not_bigger: 	bne $t3, $zero, skip # check if number is devided by 3
				addi $s6, $s6, 1	
skip:
				beq $t6, $zero, not_smaller				
				add $s2, $t7, $zero

not_smaller:	div $t7, $t4 # div with 5
				mfhi $t5
				bne $t7, $zero, not_zero
				addi $s3, $s3, 1
not_zero:		j check_even

check_even:		andi $t6, $t7, 1
				bne $t6, $zero, is_odd
				addi $s4, $s4, 1
				j check_div5

is_odd:			addi $s5, $s5, 1



check_div5:		
				bne $t5, $zero, next_element
				addi $s7, $s7, 1


#----------------------------------------------------------------------------------------------------------------------------------#
# Τεχνική για να βρούμε αριθμούς που διαιρούνται με 3 γλιτώνοντας κύκλους, υποθέτοντας ότι το div είναι πολύ κοστοβόρο σε κύκλους.
# check_div3:		lw $s6, zero # counter of even bits
#         			lw $s7, zero # counter of odd bits 
#         			lw $t0, thirty_one # counter of odd bits in sll
#         			lw $t1, thirty # counter of even bits in sll
#         			lw $t2, thirty_one #constant
  

#     loop:   beq $t1, $zero, end_loop # οταν ο counter των sll φτασει 0 βγες απο το loop

#             sll $s5, $t7, $t0 # κανε shift αριστερα $t0 θεσεις 
#             srl $s5, $s5, $t2 # shift δεξια για να μεινει το bit που θελουμε αλλα θα ειναι περιττο 
#             # γιατι το $t0 ξεκιναει απο το 31
#             addi $t0, $t0, -2 # μειωσε 2 να παραμεινει ο counter περιττος
#             beq $s5, $zero, check_next # αν το συγκεκριμενο bit ειναι 0 συνεχισε 
#             addi $s7, $s7, 1 

#     check_next: sll $s5, $t7, $t1 # ιδια διαδικασια αλλα επειδη $t1 ξεκιναει απο 30 τοτε θα παιρνει τα
#                 # αρτια bit
#                 srl $s5, $s5, $t2
#                 addi $t1, $t1, -2
#                 beq $s1, $zero, check_next2
#                 addi $s6, $s6, 1

#     check_next2:            j loop


#     end_loop:   sub $s5, $s7, $s6
#                 bne $s5, $zero, exit_section
# 				addi $s4, $s4, 1 # counter of numbers that are devided by 3
# exit_section:
#----------------------------------------------------------------------------------------------------------------------------------#

next_element:	addi $t0, $t0, 4 	# index next element of array
				addi $s0, $s0, -1	# loop repeat -1
				j main_loop
exit_program:

				la $t7, max

				sw $s1, 0($t7)	
				sw $s2, 4($t7)	
				sw $s3, 8($t7)
				sw $s4, 12($t7)
				sw $s5, 16($t7) 	
				sw $s6, 20($t7) 
				sw $s7, 24($t7) 

				li $v0, 10
				syscall


.org 0x10000000
	.data
zero: 			.word 0
max:			.word 0
min:			.word 0	
zero_counter:	.word 0
even:			.word 0
odd:			.word 0
div3:			.word 0
div5:			.word 0		
array: 			.word -4, -3, -2, -1, 0, 1, 2, 3, 4, 4, 26, -13, 31, 195, -235, 1345, 31, 1324, -43, 0, -234, 934, 43, 67, 85, 42, -34, -45, -167, 893, -273, 148, -190, 275, 139, 251, -312, 315, 13, 37, 206, 2, 52, 169, 1, 356, 56, 11, 178, 316, -123447, 12999	# list with random integers