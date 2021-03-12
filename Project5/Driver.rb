require "./Othello"

#
# Driver code to play the Othello game (DO NOT MODIFY)
# Author(s): Nandigam
#

def main()
    # ARGV array stores command-line arguments
    if ARGV.length != 3
        puts("Incorrect number of arguments to the program")
        puts("Usage: ruby Main.rb boardsize startplayernbr disccolor")
        puts("Example: ruby Main.rb 6 1 B")
        exit(1)
    end

    # extract board size, start player, and start player's disc color
    # from command-line arguments
    size = ARGV.shift.to_i
    player = ARGV.shift.to_i
    disc = ARGV.shift.upcase

    if size < 4 || size > 8 || size % 2 != 0 || player < 1 || player > 2 ||
                                    (disc != Othello::WHITE && disc != Othello::BLACK)
        puts("Invalid arguments to the program")
        exit(1)
    end

    game = Othello.new(size, player, disc)

    puts("<<<<< Welcome to the game of Othello >>>>>")
    puts("Player 1: " + game.p1Disc + "   Player 2: " + game.p2Disc)
    puts("Player " + game.turn.to_s + " starts the game...")

    while !game.isGameOver()
        puts(game.to_s + "\n")

        if !game.isValidMoveAvailable()
            puts("No valid moves available for player " + game.turn.to_s + "(" + game.disc + "). You lose your turn.")
            game.prepareNextTurn()
        else
            while true
                print("Turn> Player " + game.turn.to_s + "(" + game.disc + ") - Enter location to place your disc (row col): ")
                tokens = gets.split(' ')
                row = tokens[0].to_i
                col = tokens[1].to_i
                if row < 1 || row > game.size || col < 1 || col > game.size
                    puts("Sorry, invalid input. Try again.")
                    next    # continue with next iteration
                end
                row -= 1	# adjust it for zero-indexed board
                col -= 1    # adjust it for zero-indexed board
                if !game.isValidMove(row,col)
                    puts("Sorry, that is not a valid move. Try again.")
                    next
                end
                break
            end
            game.placeDiscAt(row,col)
        end
    end

    # print the final board and display winner or tie information
    puts(game.to_s + "\n")
    winner = game.checkWinner()
    if winner == game.p1Disc
        puts("Game is over. The winner is Player 1(" + winner + ").")
    elsif winner == game.p2Disc
        puts("Game is over. The winner is Player 2(" + winner + ").")
    else
        puts("Game is over. No winner.")
    end
end

# Invoke the driver
main()
