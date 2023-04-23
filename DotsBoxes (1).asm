.data
board: .space 221
dot: .asciiz "."
line_h: .asciiz "-"
line_v: .asciiz "|"
newline: .asciiz "\n"
invalid_input: .asciiz "Invalid input. Please enter valid row and column coordinates.\n"
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

display_board_loop:
    lb $a0, 0($s0)        # Load the ASCII value of the current cell
    li $v0, 11            # Set the system call code for printing a character
    syscall               # Print the character

    addi $t1, $t1, 1      # Increment column counter
    addi $s0, $s0, 1      # Move to the next cell in the game board

    lw $t2, board_width
    bne $t1, $t2, display_board_loop  # If column counter is not equal to board width, continue looping

    # Print a newline character
    la $a0, newline
    li $v0, 4             # Set the system call code for printing a string
    syscall

    li $t1, 0             # Reset column counter
    addi $t0, $t0, 1      # Increment row counter

    lw $t2, board_height
    bne $t0, $t2, display_board_loop  # If row counter is not equal to board height, continue looping

    jr $ra

#start of processes file

# Take user input
take_user_input:
    # ... (Code to take user input, validate it, and update the game board)

    jr $ra

# Make a move for the computer
computer_move:
    # ... (Code to make a random move for the computer and update the game board)

    jr $ra

# Check game state
check_game_state:
    # ... (Code to check if the game is over)

    jr $ra

# Display the winner
display_winner:
    # ... (Code to display the winner based on the scores)

    jr $ra
