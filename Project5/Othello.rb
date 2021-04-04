#
# Othello Game Class
# Author(s): Ummayair Ahmad, Kyle Jacobson
#

class Othello
  # Constants
  WHITE = 'W'.freeze
  BLACK = 'B'.freeze
  EMPTY = '-'.freeze
  TIE = 'T'.freeze

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
    (row >= 0 && row < @size) && (col >= 0 && col < @size)
  end

  # Initializes the board with start configuration of discs
  def initializeBoard
    # Iterate through the rows of the board.
    (0...@size).each do |i|
      # Iterate through the columns of the board.
      (0...@size).each do |j|
        # Empty spaces will be identified with a hyphen.
        @board[i][j] = '-'
      end
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
    else
      # This is required by RubyMine.
    end
  end

  # Returns true if placing the disc of current player at row,col is valid;
  # else returns false
  def isValidMove(row, col)
    isValidMoveForDisc(row, col, @disc)
  end

  # Returns true if placing the specified disc at row,col is valid;
  # else returns false
  def isValidMoveForDisc(row, col, disc)
    # Variables to help with iterating through grid successfully.
    rows = row
    cols = col

    # Iterates through the nearby positions.
    (-1..1).each do |i|
      (-1..1).each do |j|
        # Increment the row and column by i and j, respectively.
        row = rows + i
        col = cols + j

        # Checks if i and j are both zero.
        next if i.zero? && j.zero?

        # If the grid is inbounds, continue the code.
        next unless checkBounds(row, col)

        # If the board is on the game piece, or a empty spot, continue the code.
        next if (@board[row][col] == disc) || (@board[row][col] == '-')

        # Iterate through positions on grid until the code is out of bounds.
        while checkBounds(row, col)
          # If the current position is empty, break from the code.
          break if @board[row][col] == '-'

          # If the current position is the disc, return true.
          return true if @board[row][col] == disc

          # Increment the row and column by i and j, respectively.
          row += i
          col += j
        end
      end
    end

    # DO NOT DELETE - if control reaches this statement, then it is not a valid move
    false
  end

  # Places the disc of current player at row,col and flips the
  # opponent discs as needed
  def placeDiscAt(row, col)
    return unless isValidMove(row, col)

    # Returns the player disc for next turn.
    opponent_disc = prepareNextTurn

    # place the current player's disc at row,col
    @board[row][col] = @disc

    # If move is valid, run through board game process.
    if isValidMove(row, col)
      # Checks if the directional iteration is within bounds.
      if checkBounds(row, col - 1) && (@board[row][col - 1] == opponent_disc)
        # Iterates through the left spaces.
        (col - 2..0).each do |i|
          # When an empty space is encountered, break from process.
          case @board[row][i]
          when '-'
            break

            # Add current player's disc on board when appropriate.
          when @disc
            (col - 1..i).each do |j|
              @board[row][j] = @disc
            end
          else
            # This is required by RubyMine.
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row + 1, col) && (@board[row + 1][col] == opponent_disc)
        # Iterates through the down spaces.
        (row + 2..@size).each do |i|
          # When an empty space is encountered, break from process.
          case @board[i][col]
          when '-'
            break

            # Add current player's disc on board when appropriate.
          when @disc
            (row + 1..i).each do |j|
              @board[j][col] = @disc
            end
          else
            # This is required by RubyMine.
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row, col + 1) && (@board[row][col + 1] == opponent_disc)
        # Iterates through the right spaces.
        (col + 2..@size).each do |i|
          # When an empty space is encountered, break from process.
          case @board[row][i]
          when '-'
            break

            # Add current player's disc on board when appropriate.
          when @disc
            (col + 1..i).each do |j|
              @board[row][j] = @disc
            end
          else
            # This is required by RubyMine.
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row - 1, col) && (@board[row - 1][col] == opponent_disc)
        # Iterates through the up spaces.
        (row - 2..0).each do |i|
          # When an empty space is encountered, break from process.
          case @board[i][col]
          when '-'
            break

            # Add current player's disc on board when appropriate.
          when @disc
            (row - 1..i).each do |j|
              @board[j][col] = @disc
            end
          else
            # This is required by RubyMine.
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row - 1, col + 1) && (@board[row - 1][col + 1] == opponent_disc)
        # Iterates through the up-right spaces.
        (row - 2..0).each do |i|
          (col - 2..0).each do |j|
            # When an empty space is encountered, break from process.
            case @board[i][j]
            when '-'
              break

              # Add current player's disc on board when appropriate.
            when @disc
              (row - 1..i).each do |k|
                (col - 1..j).each do |l|
                  @board[k][l] = @disc
                end
              end
            else
              # This is required by RubyMine.
            end
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row + 1, col - 1) && (@board[row + 1][col - 1] == opponent_disc)
        # Iterates through the down-left spaces.
        (row + 2..@size).each do |i|
          (col - 2..0).each do |j|
            # When an empty space is encountered, break from process.
            case @board[i][j]
            when '-'
              break

              # Add current player's disc on board when appropriate.
            when @disc
              (row + 1..i).each do |k|
                (col - 1..j).each do |l|
                  @board[k][l] = @disc
                end
              end
            else
              # This is required by RubyMine.
            end
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row - 1, col + 1) && (@board[row - 1][col + 1] == opponent_disc)
        # Iterates through the up-left spaces.
        (row - 2..0).each do |i|
          (col + 2...@size).each do |j|
            # When an empty space is encountered, break from process.
            case @board[i][j]
            when '-'
              break

              # Add current player's disc on board when appropriate.
            when @disc
              (row - 1..i).each do |k|
                (col + 1..j).each do |l|
                  @board[k][l] = @disc
                end
              end
            else
              # This is required by RubyMine.
            end
          end
        end
      end

      # Checks if the directional iteration is within bounds.
      if checkBounds(row + 1, col - 1) && (@board[row + 1][col - 1] == opponent_disc)
        # Iterates through the down-right spaces.
        (row + 2...@size).each do |i|
          (col + 2...@size).each do |j|
            # When an empty space is encountered, break from process.
            case @board[i][j]
            when '-'
              break

              # Add current player's disc on board when appropriate.
            when @disc
              (row + 1..i).each do |k|
                (col + 1..j).each do |l|
                  @board[k][l] = @disc
                end
              end
            else
              # This is required by RubyMine.
            end
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
    (0...@size).each do |i|
      # Iterate through the columns of the board.
      (0...@size).each do |j|
        # Checks if space is currently empty.
        next if @board[i][j] != '-'
        # If the move is valid, return true.
        return true if isValidMove(i, j)
      end
    end

    # DO NOT DELETE - if control reaches this statement, then a valid move is not available
    false
  end

  # Returns true if the board is fully occupied with discs; else returns false
  def isBoardFull
    # Iterate through the rows of the board.
    (0...@size).each do |i|
      # Iterate through the columns of the board.
      (0...@size).each do |j|
        # If the board has empty spaces, return false.
        return false if @board[i][j] == '-'
      end
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
    white_points = 0
    black_points = 0

    # If the game is not over, return 0.
    return 0 unless isGameOver

    # Iterate through the rows of the board.
    (0...@size).each do |i|
      # Iterate through the columns of the board.
      (0...@size).each do |j|
        # If the space contains a white disc, add one point.
        white_points += 1 if @board[i][j] == 'W'

        # If the space contains a black disc, add one point.
        black_points += 1 if @board[i][j] == 'B'
      end
    end

    # If player "White" has more points than player "Black", return "White" as winner.
    return 'W' if white_points > black_points

    # If player "Black" has more points than player "White", return "Black" as winner.
    return 'B' if white_points < black_points

    # Otherwise, declare a tie.
    'T'
  end

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
