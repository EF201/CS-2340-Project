.text
.globl main

main:
    # Initialize and display the game board
    jal init_board

    # Game loop
    game_loop:
        # Display the game board
        #jal display_board

        # Take user input
.globl user_score_point
user_score_point:
        jal take_user_input
        
        jal display_board
        
        jal box_checker

        # Make a move for the computer
.globl ai_score_point
ai_score_point:
        jal computer_move
        
	jal display_board
	
	jal box_checker_ai
	
        # Check game state
        jal check_game_state
        bnez $v0, game_loop
    # Display the winner
    jal display_winner

    li $v0, 10
    syscall
