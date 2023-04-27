.data 
user_score: .word 0
ai_score: .word 0
ad: .ascii "yea"
.text
.globl box_checker
box_checker:
	li $v0, 5							#Store it
	syscall
    	
    # ... (check if a box is made)
    	#There are 6 cases to check, vertical or horizontal in middle, vertical on colume 0 or colume 16, horziontal on row 0 or 12
    	#score is tracked by user_score and AI_score
    	beq $t5, 0, case3
    	beq $t5, 16, case4
    	beq $t4, 0, case5
    	beq $t4, 12, case6
    	beq $t6, 1, case2A		#if it is - go to case 2
    	
    	#L = left, R = right, B = below, A = above
case1L:			#vertical line in the middle
	lb $s2, -2($s7)	
	bne $s2, 124, case1R
	lb $s2, -18($s7)	
	bne $s2, 45, case1R
	lb $s2, 16($s7)
	bne $s2, 45, case1R
	j yes_box
case1R:
	lb $s2, 2($s7)	
	bne $s2, 124, no_box
	lb $s2, 18($s7)	
	bne $s2, 45, no_box
	lb $s2, -16($s7)
	bne $s2, 45, no_box
	j yes_box
case2A:			#Horziontal line in the middle
	lb $s2, -16($s7)		
	bne $s2, 124, case2B
	lb $s2, -18($s7)		
	bne $s2, 124, case2B
	lb $s2, -34($s7)	
	bne $s2, 45, case2B
	
	j yes_box
case2B:
	lb $s2, 16($s7)	
	bne $s2, 124, no_box
	lb $s2, 18($s7)	
	bne $s2, 124, no_box
	lb $s2, 34($s7)
	bne $s2, 45, no_box
	j yes_box
case3:			#column 0 vertical
	lb $s2, -16($s7)	
	bne $s2, 45, no_box
	lb $s2, 18($s7)	
	bne $s2, 45, no_box
	lb $s2, 2($s7)
	bne $s2, 124, no_box
	j yes_box
case4:			#column 16 vertical
	lb $s2, 16($s7)	
	bne $s2, 45, no_box
	lb $s2, -18($s7)	
	bne $s2, 45, no_box
	lb $s2, -2($s7)
	bne $s2, 124, no_box
	j yes_box
case5:			#row 0 horziontal 
	lb $s2, 16($s7)	
	bne $s2, 124, no_box
	lb $s2, 18($s7)	
	bne $s2, 124, no_box
	lb $s2, 34($s7)
	bne $s2, 45, no_box
	j yes_box
	
case6:			#row 12 horziontal
	lb $s2, -16($s7)	
	bne $s2, 124, no_box
	lb $s2, -18($s7)	
	bne $s2, 124, no_box
	lb $s2, -34($s7)
	bne $s2, 45, no_box
	j yes_box
	
.globl box_checker_ai			#litteraly excatly the same as box_check but instead jumps to yes_box_ai when box is found
box_checker_ai:
    # ... (check if a box is made)
    	#There are 6 cases to check, vertical or horizontal in middle, vertical on colume 0 or colume 16, horziontal on row 0 or 12
    	#score is tracked by user_score and AI_score
    	beq $t5, 0, case3ai
    	beq $t5, 16, case4ai
    	beq $t4, 0, case5ai
    	beq $t4, 12, case6ai
    	beq $t6, 1, case2Aai		#if it is - go to case 2
    	
    	#L = left, R = right, B = below, A = above
case1Lai:			#vertical line in the middle
	lb $s2, -2($s7)	
	bne $s2, 124, case1Rai
	lb $s2, -18($s7)	
	bne $s2, 45, case1Rai
	lb $s2, 16($s7)
	bne $s2, 45, case1Rai
	j yes_box_ai
case1Rai:
	lb $s2, 2($s7)	
	bne $s2, 124, no_box
	lb $s2, 18($s7)	
	bne $s2, 45, no_box
	lb $s2, -16($s7)
	bne $s2, 45, no_box
	j yes_box_ai
case2Aai:			#Horziontal line in the middle
	lb $s2, -16($s7)	
	bne $s2, 45, case2Bai
	lb $s2, -18($s7)	
	bne $s2, 45, case2Bai
	lb $s2, -34($s7)
	bne $s2, 124, case2Bai
	j yes_box_ai
case2Bai:
	lb $s2, 16($s7)	
	bne $s2, 45, no_box
	lb $s2, 18($s7)	
	bne $s2, 45, no_box
	lb $s2, 34($s7)
	bne $s2, 124, no_box
	j yes_box_ai
case3ai:			#column 0 vertical
	lb $s2, -16($s7)	
	bne $s2, 45, no_box
	lb $s2, 18($s7)	
	bne $s2, 45, no_box
	lb $s2, 2($s7)
	bne $s2, 124, no_box
	j yes_box_ai
case4ai:			#column 16 vertical
	lb $s2, 16($s7)	
	bne $s2, 45, no_box
	lb $s2, -18($s7)	
	bne $s2, 45, no_box
	lb $s2, -2($s7)
	bne $s2, 124, no_box
	j yes_box_ai
case5ai:			#row 0 horziontal 
	lb $s2, 16($s7)	
	bne $s2, 124, no_box
	lb $s2, 18($s7)	
	bne $s2, 124, no_box
	lb $s2, 34($s7)
	bne $s2, 45, no_box
	j yes_box_ai
	
case6ai:			#row 12 horziontal
	lb $s2, -16($s7)	
	bne $s2, 124, no_box
	lb $s2, -18($s7)	
	bne $s2, 124, no_box
	lb $s2, -34($s7)
	bne $s2, 45, no_box
	j yes_box_ai


yes_box:
	lb $s2, user_score
	add $s2, $s2, 1
	j user_score_point
yes_box_ai:
	lb $s2, ai_score
	add $s2, $s2, 1
	j ai_score_point
no_box:
	jr $ra
