# frozen_string_literal: true

#
# Othello Game Class
# Author(s): Ummayair Ahmad, Kyle Jacobson
#

class Othello
  # Constants
  WHITE = 'W'
  BLACK = 'B'
  EMPTY = '-'
  TIE = 'T'

  # Creates getter methods for instance variables @size, @turn, @disc,
  # @p1Disc, and @p2Disc
  attr_reader :size, :turn, :disc, :p1Disc, :p2Disc

  # Constructs and initializes the board of given size
  def initialize(size, startPlayer, discColor)
    # validate arguments
    raise ArgumentError, 'Invalid value for board size.' if size < 4 || size > 8 || size.odd?
    raise ArgumentError, 'Invalid value for player number.' if startPlayer < 1 || startPlayer > 2
    raise ArgumentError, 'Invalid value for disc.' if discColor != WHITE && discColor != BLACK

    # set instance variables
    @board = []
    @size = size
    @turn = startPlayer
    @disc = discColor

    # set two more instance variables @p1Disc and @p2Disc
    if @turn == 1
      @p1Disc = @disc
      @p2Disc = @disc == WHITE ? BLACK : WHITE
    else
      @p2Disc = @disc
      @p1Disc = @disc == WHITE ? BLACK : WHITE
    end

    # create the grid (as array of arrays)
    @board = Array.new(@size)
    (0...@board.length).each do |i|
      @board[i] = Array.new(@size)
      @board[i].fill(0)
    end

    # initialize the grid
    initializeBoard
  end

  # Checks if a cell is outside the range of the boards playing field
  def checkBounds(row, col)      
    return (row >= 0 && row < @size) && (col >= 0 && col < @size)
  end

  # Initializes the board with start configuration of discs
  def initializeBoard
    # Iterate through the rows of the board.
    for i in (0...@size)
      # Iterate through the columns of the board.
      for j in (0...@size)
        # Empty spaces will be identified with a hyphen.
         @board[i][j] = '-';
      j += 1
      end
    i += 1
    end

    # Switch used for initializing different board sizes.
    case @size 
    # 4x4 initial board layout.
    when 4
      @board[1][1] = 'B'
      @board[2][1] = 'W'
      @board[1][2] = 'W'
      @board[2][2] = 'B'
    # 6x6 initial board layout.
    when 6
      @board[2][2] = 'B'
      @board[3][2] = 'W'
      @board[2][3] = 'W'
      @board[3][3] = 'B'
    # 8x8 initial board layout.
    when 8
      @board[3][3] = 'B'
      @board[4][3] = 'W'
      @board[3][4] = 'W'
      @board[4][4] = 'B'
    end
  end

  # Returns true if placing the disc of current player at row,col is valid;
  # else returns false
  def isValidMove(row, col)
    isValidMoveForDisc(row, col, @disc)
  end

  # Returns true if placing the specified disc at row,col is valid;
  # else returns false
  def isValidMoveForDisc(_row, _col, _disc)
    # Variables to help with iterating through grid successfully.
    rows = _row;
    cols = _col;

    # Iterates through the nearby positions.
    for i in -1..1
      for j in -1..1
        # Increment the row and column by i and j, respectively.
        row = rows + i;
        col = cols + j;

        # If the grid is inbounds, continue the code.
        if (!checkBounds(row, col))
          next
        end

        # If the board is on the game piece, or a empty spot, continue the code.
        if (@board[row][col] == disc || @board[row][col] == "-") 
          next
        end

        # Iterate through positions on grid until the code is out of bounds.
        while (checkBounds(row, col))
          # If the current position is empty, break from the code.
          if (@board[row][col] == "-") 
            break
          end

          # If the current position is the disc, return true.
          if (@board[row][col] == disc) 
            true
          end

          # Increment the row and column by i and j, respectively.
          row += i;
          col += j;
        end
      j += 1
      end
    i += 1
    end

    # DO NOT DELETE - if control reaches this statement, then it is not a valid move
    false
  end

  # Places the disc of current player at row,col and flips the
  # opponent discs as needed
  def placeDiscAt(row, col)
    return unless isValidMove(row, col)

    # Returns the player disc for next turn.
    opponentDisc = @prepareNextTurn

    # place the current player's disc at row,col
    @board[row][col] = @disc
 
    # If move is valid, run through board game process.
    if (isValidMove(row, col))
      # Checks if the directional iteration is within bounds.
      if (checkBounds(row, col - 1))
        # Checks if adjacent space is occupied by opponent.
        if (@board[row][col - 1] == opponentDisc)
          # Iterates through the left spaces.
          for i in col-2...0
            # When an empty space is encountered, break from process.
            if (@board[row][i] == '-')
              break

            # Add current player's disc on board when appropriate.
            elsif (@board[row][i] == @disc)
              for j in col-1...i
                @board[row][j] = @disc;
                j -= 1
              end
            end
          i -= 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row + 1, col)) 
        # Reassign right spaces to current player when appropriate.
        if (@board[row + 1][col] == opponentDisc) 
          #Iterates through the down spaces.
          for i in row+2...@size
            # When an empty space is encountered, break from process.
            if (@board[i][col] == '-') 
              break

            # Add current player's disc on board when appropriate.
            elsif (@board[i][col] == @disc) 
              for j in row+1...i
                @board[j][col] = @disc;
                j += 1
              end
            end
          i += 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row, col + 1)) 
        # Reassign down spaces to current player when appropriate.
        if (@board[row][col + 1] == opponentDisc) 
          # Iterates through the right spaces.
          for i in col+2...@size
            # When an empty space is encountered, break from process.
            if (@board[row][i] == '-') 
              break

            # Add current player's disc on board when appropriate.
            elsif (@board[row][i] == @disc) 
              for j in col+1...i
                @board[row][j] = @disc;
                j += 1
              end
            end
          i += 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row - 1, col)) 
        # Reassign left spaces to current player when appropriate.
        if (@board[row - 1][col] == opponentDisc) 
          # Iterates through the up spaces.
          for i in row-2...0
            # When an empty space is encountered, break from process.
            if (@board[i][col] == '-') 
              break

            # Add current player's disc on board when appropriate.
            elsif (@board[i][col] == @disc) 
              for j in row-1...i
                @board[j][col] = @disc;
                j -= 1
              end
            end
          i -= 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row - 1, col + 1)) 
        # Reassign up-left spaces to current player when appropriate.
        if (@board[row - 1][col + 1] == opponentDisc) 
          # Iterates through the up-right spaces.
          for i in row-2...0
            for j in col-2...0
              # When an empty space is encountered, break from process.
              if (@board[i][j] == '-') 
                break

              # Add current player's disc on board when appropriate.
              elsif (@board[i][j] == @disc) 
                for k in row-1...i
                  for l in col-1...j
                    @board[k][l] = @disc;
                    l -= 1
                  end
                k -= 1
                end
              end
            j -= 1
            end
          i -= 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row + 1, col - 1)) 
        # Reassign up-right spaces to current player when appropriate.
        if (@board[row + 1][col - 1] == opponentDisc) 
          # Iterates through the down-left spaces.
          for i in row+2...@size
            for j in col-2...0
              # When an empty space is encountered, break from process.
              if (@board[i][j] == '-') 
                break

              # Add current player's disc on board when appropriate.
              elsif (@board[i][j] == @disc) 
                for k in row+1...i
                  for l in col-1...j
                    @board[k][l] = @disc;
                    l -= 1
                  end
                k += 1
                end
              end
            j -= 1
            end
          i += 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row - 1, col + 1)) 
        # Reassign down-left spaces to current player when appropriate.
        if (@board[row - 1][col + 1] == opponentDisc) 
          # Iterates through the up-left spaces.
          for i in row-2...0
            for j in col+2...@size
              # When an empty space is encountered, break from process.
              if (@board[i][j] == '-') 
                break

              # Add current player's disc on board when appropriate.
              elsif (@board[i][j] == @disc) 
                for k in row-1...i
                  for l in col+1...j
                    @board[k][l] = @disc;
                    l += 1
                  end 
                k -= 1
                end
              end
            j += 1
            end
          i -= 1
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if (checkBounds(row + 1, col - 1)) 
        # Reassign down-right spaces to current player when appropriate.
        if (@board[row + 1][col - 1] == opponentDisc) 
          # Iterates through the down-right spaces.
          for i in row+2...@size
            for j in col+2...@size
              # When an empty space is encountered, break from process.
              if (@board[i][j] == '-') 
                break

              # Add current player's disc on board when appropriate.
              elsif (@board[i][j] == @disc) 
                for k in row+1...i
                  for l in col+1...j
                    @board[k][l] = @disc;
                    l += 1
                  end
                k += 1
                end
              end
            j += 1
            end
          i += 1
          end
        end
      end
    end

    # DO NOT DELETE - prepares for next turn if game is not over
    prepareNextTurn unless isGameOver
  end

  # Sets @turn and @disc instance variables for next player
  def prepareNextTurn
    @turn = if @turn == 1
              2
            else
              1
            end
    @disc = if @disc == WHITE
              BLACK
            else
              WHITE
            end
  end

  # Returns true if a valid move for current player is available;
  # else returns false
  def isValidMoveAvailable
    isValidMoveAvailableForDisc(@disc)
  end

  # Returns true if a valid move for the specified disc is available;
  # else returns false
  def isValidMoveAvailableForDisc(_disc)
    # Iterate through the rows of the board.
    for i in @size
      # Iterate through the columns of the board.
      for j in @size
        # Checks if space is currently empty.
        if (@board[i][j] == '-')
          # If the move is valid, return true.
          if (isValidMove(i, j, _disc))
            true
          end
        end
      j += 1
      end
    i += 1
    end

    # DO NOT DELETE - if control reaches this statement, then a valid move is not available
    false
  end

  # Returns true if the board is fully occupied with discs; else returns false
  def isBoardFull
    # Iterate through the rows of the board.
    for i in @size 
      # Iterate through the columns of the board.
      for j in @size 
        # If the board has empty spaces, return false.
        if (@board[i][j] == '-')
          false
        end
      j += 1
      end
    i += 1
    end
    true
  end

  # Returns true if either the board is full or a valid move is not available
  # for either disc
  def isGameOver
    isBoardFull ||
      (!isValidMoveAvailableForDisc(WHITE) &&
                      !isValidMoveAvailableForDisc(BLACK))
  end

  # If there is a winner, it returns Othello::WHITE or Othello::BLACK.
  # In case of a tie, it returns Othello::TIE
  def checkWinner
    # Counts the amount of points allocated to each player.
    whitePoints = 0;
    blackPoints = 0;

    # If the game is not over, return 0.
    if (!isGameOver(@size, @board))
      return 0
    end

    # Iterate through the rows of the board.
    for i in @size
      # Iterate through the columns of the board.
      for j in @size 
        # If the space contains a white disc, add one point.
        if (@board[i][j] == 'W') 
          whitePoints += 1
        end

        # If the space contains a black disc, add one point.
        if (@board[i][j] == 'B') 
          blackPoints += 1
        end
      j += 1
      end
    i += 1
    end

    # If player "White" has more points than player "Black", return "White" as winner.
    if (whitePoints > blackPoints) 
      return 'W'
    end
  
    # If player "Black" has more points than player "White", return "Black" as winner.
    if (whitePoints < blackPoints) 
      return 'B'
    end
    # Otherwise, declare a tie.
    return 'T'
  end

  # Returns a string representation of the board
  def to_s
    str = "\n  "
    (0...@size).each do |i|
      str << "#{i + 1} "
    end
    str << "\n"
    (0...@size).each do |i|
      str << "#{i + 1} "
      str << "#{@board[i].join(' ')}\n"
    end
    str
  end
end
