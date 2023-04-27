.data
end: .asciiz "Game Over.\n"
user_display_score: .asciiz "User score: "
comp_display_score: .asciiz "\nComputer score: "
winner: .asciiz "Winner: "
user_wins: .asciiz "User\n"
comp_wins: .asciiz "Computer\n"
tie: .asciiz "Tie\n"
comp_input: .asciiz "\nComputer Input:\n"
user_input_row: .asciiz "Enter the row: "
user_input_column: .asciiz "Enter the column: "
invalid_input: .asciiz "Invalid input. Please enter a valid value. \n"
repeated_input: .asciiz "Repeated input. Please enter a valid value!\n"
all_user_input: .space 221
pitch: .byte 1
duration: .byte 50
instrument: .byte 50
volume: .byte 50
turn_count: .word 0
user_score: .word 0
ai_score: .word 0

.text
# Take user input
.globl take_user_input
take_user_input:
    # ... (Code to take user input, validate it, and update the game board)
	la $s1, all_user_input	# Load the address of input history
	li $s7, 16
	li $s6, 12

	li $v0, 4
	la $a0, user_input_row 				#Have the user input the row
	syscall
	
	li $v0, 5							#Store it
	syscall
	move $t4, $v0
			
	bgt $t4, $s6, user_invalid_input	#Error check - value not > 12
	
	li $v0, 4
	la $a0, user_input_column 			#Have the user input the column
	syscall
	
	li $v0, 5							#Store it
	syscall
	move $t5, $v0

	bgt $t5, $s7, user_invalid_input	#Error check - value not > 16
	
	add $t7, $t4, $t5					#Add row and column, check if sum is odd
	rem $t7, $t7, 2						#If true, ignore, else, invalid input
	beqz $t7, user_invalid_input 
	
	add $t8, $t4, 48					#add 48 to user input to the get ASCII value of them
	add $t9, $t5, 48					#this converts the row and colume int to ASCII 
	j check_for_repeat_loop	
	
    #j computer_move
    #jr $ra

check_for_repeat_loop:
	lb $s2, 0($s1)
	beqz $s2, if_equal_zero				#check if the first value in all user input is 0, if so check the second one
not_equal_zero:	
	#loop through all_user_input checking for matches or for 0, if 0 is found that means thats the last inputted value and jump to here and enter the 2 new values
	lb $s2, 0($s1)
	bne $s2, $t8, increment_history
	lb $s2, 1($s1)
	bne $s2, $t9, increment_history
	li $v0, 4
	la $a0, repeated_input
	syscall
	j take_user_input
increment_history:
	addi $s1, $s1, 2
	j check_for_repeat_loop
if_equal_zero:
	lb $s2, 1($s1)
	bnez $s2 not_equal_zero				#if the second one is not 0 then compare the user input to past input
	sb $t8, 0($s1)						#if it is zero that means its a new input and is vaild
	sb $t9, 1($s1)						#store it in the history
	#j display_board
	#j check_boxes						#since input is vaild check if it makes a box
return_label:
	jr $ra

user_invalid_input:
	li $v0, 4
	la $a0, invalid_input
	syscall
	
	j take_user_input
	
# Make a move for the computer
.globl computer_move
computer_move:
    # ... (Code to make a random move for the computer and update the game board)
    li $s7, 16
	li $s6, 12
	
	li $v0, 42             # Pseudo-random number generator system call to generate the row
	li $a1, 13
    syscall
	
	#Store it
	move $t4, $a0
			
	bgt $t4, $s6, comp_invalid_input	#Error check - value not > 12
	
	li $v0, 42             # Pseudo-random number generator system call to generate the column
	li $a1, 17
    syscall
	
	#Store it
	move $t5, $a0

	bgt $t5, $s7, comp_invalid_input	#Error check - value not > 16
	
	add $t7, $t4, $t5			#Add row and column, check if sum is odd
	rem $t7, $t7, 2				#If true, ignore, else, invalid input
	beqz $t7, comp_invalid_input 
	
	li $v0, 4
	la $a0, comp_input
	syscall
	
    #j display_board
    jr $ra
    
    comp_invalid_input:
	j computer_move
	
# Check game state
.globl increment_turn
increment_turn:
	lw $s3, turn_count
	addi $s3, $s3, 1
	sw $s3, turn_count
	jr $ra

.globl check_game_state
check_game_state:
    # ... (Code to check if the game is over)
    	lw $s3, turn_count
	bne $s3, 110, not_over
	j game_over
	
not_over:
	jr $ra
		
# Display the winner
game_over:
    # ... (Code to display the winner based on the scores)
	li $v0, 4
	la $a0, end
	syscall
	
	li $v0, 4
	la $a0, user_display_score
	syscall
	
	li $v0, 1
	lw $t4, user_score
	syscall
	
	li $v0, 4
	la $a0, comp_display_score
	syscall
	
	li $v0, 1
	lw $a0, ai_score
	syscall
	
	li $v0, 4
	la $a0, winner
	syscall
	
	lw $t4, user_score
	lw $t5, ai_score
	
	beq $t4, $t5, winner_tie
	bgt $t4, $t5, winner_user
	li $v0, 4
	la $a0, comp_wins
	syscall
	
   	li $v0, 10
    	syscall
    	
winner_tie:
	li $v0, 4
	la $a0, tie
	syscall
	
	jr $ra
winner_user:
	li $v0, 4
	la $a0, user_wins
	syscall
	
	jr $ra

.globl increment_user_score
increment_user_score:
	lw $s2, user_score
	addi $s2, $s2, 1
	sw $s2, user_score
	
	jr $ra
	
.globl increment_ai_score
increment_ai_score:
	lw $s2, ai_score
	addi $s2, $s2, 1
	sw $s2, ai_score
	
	jr $ra
	
.globl play_sound
play_sound:
	li $v0, 31 
	la $t0, pitch
	la $t1, duration 
	la $t2, instrument
	la $t3, volume 
	move $a0, $t0 
	move $a1, $t1 
	move $a2, $t2
	move $a3, $t3 
	syscall 
	
	jr $ra
