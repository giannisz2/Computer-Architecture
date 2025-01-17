# .org 0x80020000
	.text 
	.globl main
main:
				li $s0, 500			# load to $s0 the array size
				la $t0, array			# load to $t0 address of array
				lw $s1, 0($t0)	        # initial max is array[0]  $s1 == max
				lw $s2, 0($t0)	        # initial min is array[0]  $s2 == min

				# counters for project requests
				add $s3, $zero, $zero 	# initialize $s3, counter for 0's
				add $s4, $zero, $zero	# initialize $s4, counter for even numbers
				add $s5, $zero, $zero	# initialize $s5, counter for odd numbers
				add $s6, $zero, $zero	# initialize $s6, counter for numbers that are devided by 3
				add $s7, $zero, $zero	# initialize $s7, counter for numbers that are devided by 5






main_loop:		beq $s0, $zero, exit_program	# main loop if( $s0 == 0)then exit ftom main loop (initial $s0 == size of array)
				lw $t7, 0($t0)	    		# $t7 has the elements of array in every loop
			

#---------------  count of zero, max, min, odd, even, div3 and div5 check element of list -----------------------------------------------#

				slt $t5, $s1, $t7	
				beq $t5, $zero, not_bigger			
				add $s1, $t7, $zero
				j check_even 

not_bigger: 
				slt $t5, $t7, $s2
				beq $t5, $zero, check_even
				add $s2, $t7, $zero

				

check_even:		andi $t6, $t7, 1
				bne $t6, $zero, is_odd
				addi $s4, $s4, 1
				bne $t7, $zero, not_zero
				addi $s3, $s3, 1
not_zero:				j check_div3

is_odd:			addi $s5, $s5, 1

check_div3:		li $t3, 3
				div $t7, $t3
				mfhi $t5
				bne $t5, $zero, check_div5
				addi $s6, $s6, 1

check_div5:		
				li $t3, 5
				div $t7, $t3
				mfhi $t5
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

# .org 0x10000000
	.data
zero: 			.word 0
max:			.word 0
min:			.word 0	
zero_counter:		.word 0
even:			.word 0
odd:			.word 0
div3:			.word 0
div5:			.word 0		
array: .word -429,487,380,-967,691,250,217,53,853,431,-98,344,815,141,-925,-372,94,212,509,-644,449,767,-653,193,-104,909,957,140,543,200,-732,576,-609,412,228,-86,-548,207,327,-730,-921,-733,-38,300,640,-48,939,-302,-229,-44,947,-659,-15,802,-617,921,946,555,952,231,-290,719,-113,-756,955,-524,860,672,787,-421,-583,-541,-591,22,378,-323,-807,-549,-19,-720,-588,-813,61,-954,227,780,-475,-321,820,-80,-105,5,383,-538,-316,106,938,840,607,41,726,-811,962,897,-127,-503,884,-690,-451,-681,-483,-457,564,551,-907,74,328,-194,967,275,477,-969,-530,-907,-375,-176,29,258,367,987,37,-426,860,265,-703,-99,-218,891,431,-783,82,-834,-13,-699,-57,-446,-94,-938,-695,-313,937,-974,-988,63,252,-155,-633,705,-595,920,792,817,362,617,-251,654,18,-825,-968,929,342,613,19,108,-319,-307,-886,-783,-945,-221,-850,488,-650,-336,-239,-884,717,971,-345,-669,756,-212,963,151,535,372,-238,422,40,281,-637,239,-426,-196,-565,-760,393,656,597,366,489,-534,-187,856,675,-256,-700,0,-33,505,-630,483,-665,-61,2,-933,389,-657,-38,-5,355,530,-529,21,263,417,-351,-163,46,-257,-911,-173,876,-166,-31,-590,337,863,864,188,32,-600,-323,621,-609,813,-824,616,269,-277,-214,-183,815,434,106,-869,25,585,-625,346,856,-373,-178,302,578,-751,821,137,34,-534,532,-76,-962,-915,-627,305,-749,406,769,908,-481,284,606,791,804,433,173,-906,368,817,-310,541,-947,-688,723,-297,-287,-961,864,-91,-978,236,332,273,-687,-437,923,-744,-914,-704,-435,-597,-370,209,-913,85,422,647,-17,434,439,833,438,-503,264,-649,106,113,993,-85,444,-170,781,-448,646,17,-727,816,917,-688,-315,-781,-379,461,654,449,-879,-296,466,734,235,951,-263,71,201,-535,-741,346,665,313,387,-298,-659,-226,-866,509,-184,-296,94,388,-564,-269,310,-124,381,476,1,641,-968,209,308,-192,-325,287,541,-41,-891,506,-75,167,-765,583,339,837,831,-861,-782,776,-772,677,-900,881,-473,-532,16,949,-553,163,-59,68,773,-564,-612,-436,-557,-286,-883,-329,-236,-623,763,44,493,339,-161,-112,-333,-425,-792,339,-220,-391,-996,-482,451,-24,-134,790,54,519,-810,-457,937,52,-636,925,827,914,938,928,153,66,-911,585,655,828,334,0,191,336,-773	# list with random integers
