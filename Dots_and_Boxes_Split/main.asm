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
        bnez $v0, game_loop

    # Display the winner
    jal display_winner

    li $v0, 10
    syscall
