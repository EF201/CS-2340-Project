.data
board: .space 221
dot: .asciiz "."
line_h: .asciiz "-"
line_v: .asciiz "|"
newline: .asciiz "\n"
user_input_row: .asciiz "Enter the row: "
user_input_column: .asciiz "Enter the column: "
invalid_input: .asciiz "Invalid input. Please enter valid a value. \n"
game_over: .asciiz "Game Over!\n"
user_score: .asciiz "User score: "
comp_score: .asciiz "Computer score: "
winner: .asciiz "Winner: "
user_wins: .asciiz "User\n"
comp_wins: .asciiz "Computer\n"
tie: .asciiz "Tie\n"

.text
.globl main
main:
    # Initialize the game board
    jal init_board

    # Game loop
    game_loop:
        # Display the game board
        jal display_board

        # Take user input
        jal take_user_input
        
        jal display_board

        # Make a move for the computer
        jal computer_move

        # Check game state
        jal check_game_state
        beqz $v0, game_loop

    # Display the winner
    jal display_winner

    li $v0, 10
    syscall

#this will be a board manager file or smth
.data
board_width: .word 17
board_height: .word 13
.text
# Initialize the game board
init_board:
    la $s0, board       # Load the address of the game board
    li $t0, 0           # Initialize row counter
    li $t1, 0           # Initialize column counter

init_board_loop:
    rem $t2, $t0, 2
    rem $t3, $t1, 2
    beq $t2, 0, init_board_check_column    # If row is even, check column

init_board_write_space:
    li $t2, ' '         # Load the ASCII value of a space
    sb $t2, 0($s0)       # Store the space in the current position
    j init_board_next
	
init_board_check_column:
    beq $t3, 0, init_board_write_dot       # If column is even, write a dot
    j init_board_write_space               # Else, write a space

init_board_write_dot:
    li $t2, '.'         # Load the ASCII value of a dot
    sb $t2, 0($s0)       # Store the dot in the current position

init_board_next:
    addi $t1, $t1, 1    # Increment column counter
    addi $s0, $s0, 1    # Move to the next cell in the game board

    lw $t3, board_width
    bne $t1, $t3, init_board_loop  # If column counter is not equal to board width, continue looping

    li $t1, 0           # Reset column counter
    addi $t0, $t0, 1    # Increment row counter

    lw $t3, board_height
    bne $t0, $t3, init_board_loop  # If row counter is not equal to board height, continue looping

    jr $ra

.text
# Display the game board
display_board:
    la $s0, board         # Load the address of the game board
    li $t0, 0             # Initialize row counter
    li $t1, 0             # Initialize column counter
    
display_input_loop:
	add $t7, $t6, $t5		#Prevent it from running initially
	beqz $t7 display_board_loop

	bne $t5, $t1, display_board_loop	#See if it is at the right column
	bne $t4, $t0, display_board_loop	#See if it is at the right row
	rem $t6, $t5, 2 					#If column is even, write '|', else write '_'
	beq  $t6, 1, write_underscore
	li $t2, '|'         				#Write '|' character
    sb $t2, 0($s0)
    j display_board_loop
    
write_underscore:						#Write '_' character
	li $t2, '_'
    sb $t2, 0($s0)
    j display_board_loop
    
display_board_loop:
    lb $a0, 0($s0)        # Load the ASCII value of the current cell
    li $v0, 11            # Set the system call code for printing a character
    syscall               # Print the character

    addi $t1, $t1, 1      # Increment column counter
    addi $s0, $s0, 1      # Move to the next cell in the game board
    

display_board_loop_cont:

    lw $t2, board_width
    bne $t1, $t2, display_input_loop  # If column counter is not equal to board width, continue looping

    # Print a newline character
    la $a0, newline
    li $v0, 4             # Set the system call code for printing a string
    syscall

    li $t1, 0             # Reset column counter
    addi $t0, $t0, 1      # Increment row counter

    lw $t2, board_height
    bne $t0, $t2, display_input_loop  # If row counter is not equal to board height, continue looping
    
    #j computer_move
    #j take_user_input
    jr $ra

#start of processes file

# Take user input
take_user_input:
    # ... (Code to take user input, validate it, and update the game board)
	li $s7, 16
	li $s6, 12

	li $v0, 4
	la $a0, user_input_row 		#Have the user input the row
	syscall
	
	li $v0, 5				#Store it
	syscall
	move $t4, $v0
			
	bgt $t4, $s6, user_invalid_input	#Error check - value not > 12
	
	li $v0, 4
	la $a0, user_input_column 		#Have the user input the column
	syscall
	
	li $v0, 5				#Store it
	syscall
	move $t5, $v0

	bgt $t5, $s7, user_invalid_input	#Error check - value not > 16
	
	add $t7, $t4, $t5			#Add row and column, check if sum is odd
	rem $t7, $t7, 2				#If true, ignore, else, invalid input
	beqz $t7, user_invalid_input 
    #j computer_move
    jr $ra

user_invalid_input:
	li $v0, 4
	la $a0, invalid_input
	syscall
	
	j take_user_input
	
# Make a move for the computer
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
    j display_board
    #jr $ra
    
    comp_invalid_input:
	j computer_move
	
# Check game state
check_game_state:
    # ... (Code to check if the game is over)
    jr $ra

# Display the winner
display_winner:
    # ... (Code to display the winner based on the scores)

    jr $ra
