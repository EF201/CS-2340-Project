.data 
.text
.globl box_checker
box_checker:

	# Save $ra to the stack
	addi $sp, $sp, -4        # Allocate 4 bytes on the stack (MIPS uses 4-byte words)
	sw   $ra, 0($sp)         # Store $ra at the new top of the stack
	
	add $s4, $zero, $zero
    	
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
	li $s6, 'P'
	sb $s6, -1($s7)
	jal yes_box
	
case1R:
	lb $s2, 2($s7)	
	bne $s2, 124, return
	lb $s2, 18($s7)	
	bne $s2, 45, return
	lb $s2, -16($s7)
	bne $s2, 45, return
	li $s6, 'P'
	sb $s6, 1($s7)
	jal yes_box
	
	j return
	
case2A:			#Horziontal line in the middle
	lb $s2, -16($s7)		
	bne $s2, 124, case2B
	lb $s2, -18($s7)		
	bne $s2, 124, case2B
	lb $s2, -34($s7)	
	bne $s2, 45, case2B
	li $s6, 'P'
	sb $s6, -17($s7)
	jal yes_box
case2B:
	lb $s2, 16($s7)	
	bne $s2, 124, return
	lb $s2, 18($s7)	
	bne $s2, 124, return
	lb $s2, 34($s7)
	bne $s2, 45, return
	li $s6, 'P'
	sb $s6, 17($s7)
	jal yes_box
	
	j return

case3:			#column 0 vertical
	lb $s2, -16($s7)	
	bne $s2, 45, return
	lb $s2, 18($s7)	
	bne $s2, 45, return
	lb $s2, 2($s7)
	bne $s2, 124, return
	li $s6, 'P'
	sb $s6, 1($s7)
	jal yes_box
	
	j return
case4:			#column 16 vertical
	lb $s2, 16($s7)	
	bne $s2, 45, return
	lb $s2, -18($s7)	
	bne $s2, 45, return
	lb $s2, -2($s7)
	bne $s2, 124, return
	li $s6, 'P'
	sb $s6, -1($s7)
	jal yes_box
	
	j return
case5:			#row 0 horziontal 
	lb $s2, 16($s7)	
	bne $s2, 124, return
	lb $s2, 18($s7)	
	bne $s2, 124, return
	lb $s2, 34($s7)
	bne $s2, 45, return
	li $s6, 'P'
	sb $s6, 17($s7)
	j yes_box
	
	j return
	
case6:			#row 12 horziontal
	lb $s2, -16($s7)	
	bne $s2, 124, return
	lb $s2, -18($s7)	
	bne $s2, 124, return
	lb $s2, -34($s7)
	bne $s2, 45, return
	li $s6, 'P'
	sb $s6, -17($s7)
	j yes_box
	
	j return
	
.globl box_checker_ai			#literaly excatly the same as box_check but instead jumps to yes_box_ai when box is found
box_checker_ai:

	# Save $ra to the stack
	addi $sp, $sp, -4        # Allocate 4 bytes on the stack (MIPS uses 4-byte words)
	sw   $ra, 0($sp)         # Store $ra at the new top of the stack
	
	add $s4, $zero, $zero
    	
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
	li $s6, 'C'
	sb $s6, -1($s7)
	jal yes_box_ai
	
case1Rai:
	lb $s2, 2($s7)	
	bne $s2, 124, return_ai
	lb $s2, 18($s7)	
	bne $s2, 45, return_ai
	lb $s2, -16($s7)
	bne $s2, 45, return_ai
	li $s6, 'C'
	sb $s6, 1($s7)
	jal yes_box_ai
	
	j return_ai
	
case2Aai:			#Horziontal line in the middle
	lb $s2, -16($s7)		
	bne $s2, 124, case2Bai
	lb $s2, -18($s7)		
	bne $s2, 124, case2Bai
	lb $s2, -34($s7)	
	bne $s2, 45, case2Bai
	li $s6, 'C'
	sb $s6, -17($s7)
	jal yes_box_ai
case2Bai:
	lb $s2, 16($s7)	
	bne $s2, 124, return_ai
	lb $s2, 18($s7)	
	bne $s2, 124, return_ai
	lb $s2, 34($s7)
	bne $s2, 45, return_ai
	li $s6, 'C'
	sb $s6, 17($s7)
	jal yes_box_ai
	
	j return

case3ai:			#column 0 vertical
	lb $s2, -16($s7)	
	bne $s2, 45, return_ai
	lb $s2, 18($s7)	
	bne $s2, 45, return_ai
	lb $s2, 2($s7)
	bne $s2, 124, return_ai
	li $s6, 'C'
	sb $s6, 1($s7)
	jal yes_box_ai
	
	j return_ai
case4ai:			#column 16 vertical
	lb $s2, 16($s7)	
	bne $s2, 45, return_ai
	lb $s2, -18($s7)	
	bne $s2, 45, return_ai
	lb $s2, -2($s7)
	bne $s2, 124, return_ai
	li $s6, 'C'
	sb $s6, -1($s7)
	jal yes_box_ai
	
	j return_ai
case5ai:			#row 0 horziontal 
	lb $s2, 16($s7)	
	bne $s2, 124, return_ai
	lb $s2, 18($s7)	
	bne $s2, 124, return_ai
	lb $s2, 34($s7)
	bne $s2, 45, return_ai
	li $s6, 'C'
	sb $s6, 17($s7)
	j yes_box_ai
	
	j return_ai
	
case6ai:			#row 12 horziontal
	lb $s2, -16($s7)	
	bne $s2, 124, return_ai
	lb $s2, -18($s7)	
	bne $s2, 124, return_ai
	lb $s2, -34($s7)
	bne $s2, 45, return_ai
	li $s6, 'C'
	sb $s6, -17($s7)
	j yes_box_ai
	
	j return_ai

yes_box:
	# Save $ra to the stack
	addi $sp, $sp, -4        # Allocate 4 bytes on the stack (MIPS uses 4-byte words)
	sw   $ra, 0($sp)         # Store $ra at the new top of the stack

	jal increment_user_score
	jal play_good_sound

	# Restore $ra from the stack
	lw   $ra, 0($sp)         # Load the value at the top of the stack into $ra
	addi $sp, $sp, 4         # Deallocate the 4 bytes from the stack
	
	addi $s4, $s4, 1
	
	
	jr $ra

yes_box_ai:
	# Save $ra to the stack
	addi $sp, $sp, -4        # Allocate 4 bytes on the stack (MIPS uses 4-byte words)
	sw   $ra, 0($sp)         # Store $ra at the new top of the stack

	jal increment_ai_score

	# Restore $ra from the stack
	lw   $ra, 0($sp)         # Load the value at the top of the stack into $ra
	addi $sp, $sp, 4         # Deallocate the 4 bytes from the stack
	
	addi $s4, $s4, 1
	
	jr $ra
	
return:

	# Restore $ra from the stack
	lw   $ra, 0($sp)         # Load the value at the top of the stack into $ra
	addi $sp, $sp, 4         # Deallocate the 4 bytes from the stack
	
	bgtz $s4, user_score_point
	
	# Play a neutral sound
	addi $sp, $sp, -4        # Allocate 4 bytes on the stack (MIPS uses 4-byte words)
	sw   $ra, 0($sp)         # Store $ra at the new top of the stack
	jal play_sound
	# Restore $ra from the stack
	lw   $ra, 0($sp)         # Load the value at the top of the stack into $ra
	addi $sp, $sp, 4         # Deallocate the 4 bytes from the stack
	
	jr $ra
	
return_ai:
	
	# Restore $ra from the stack
	lw   $ra, 0($sp)         # Load the value at the top of the stack into $ra
	addi $sp, $sp, 4         # Deallocate the 4 bytes from the stack
	
	bgtz $s4, ai_score_point
	
	jr $ra
