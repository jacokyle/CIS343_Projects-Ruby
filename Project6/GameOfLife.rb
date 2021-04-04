# frozen_string_literal: true

#
#  Game of Life class
#
#  Author(s): Ummayair Ahmad, Kyle Jacobson
#
class GameOfLife
  # Creates getter methods for instance variables @rows and @cols
  attr_reader :rows, :cols

  # Constructor that initializes instance variables with default values
  def initialize
    @grid = []
    @rows = 0
    @cols = 0
  end

  # Reads data from the file, instantiates the grid, and loads the
  # grid with data from file. Sets @grid, @rows, and
  # @cols instance variables for later use.
  def loadGrid(file)
    # Read the file into the data variable.
    data = IO.read(file)
    # Split data using whitespace delimiter.
    tokens = data.strip.split(' ')

    # Get number of rows and columns from the line read.
    @rows = tokens.shift.to_i
    @cols = tokens.shift.to_i

    # Create empty two-dimensional array for grid.
    @grid = Array(@rows)
    for i in 0...@rows do 
      @grid[i] = Array.new(@cols)
      @grid[i].fill(0)
    end

    # Assign values from file to the grid.
    for i in 0...@rows do
      for j in 0...@cols do
        @grid[i][j] = tokens.shift[0].to_i
      end
    end
  end

  # Saves the current grid values to the file specified.
  def saveGrid(file)
    data = "#{@rows} #{@cols}"

    # Iterates through the rows of the grid.
    for i in (0...@rows) 
      for j in (0...@cols) 
	data += ' '
	data += @grid[i][j].to_s
      end
    end

    # Write the data into a file.
    data += "\n"
    IO.write(file, data)
  end

  # Mutates the grid to next generation.
  def mutate
    # Create a copy of the grid and fill it with zeros.
    temp = Array.new(@rows)
    (0...@rows).each do |i|
      temp[i] = Array.new(@cols)
      temp[i].fill(0)
    end

    # Iterates through the rows of the grid.
      for i in 0...@rows
      # Iterates through the columns of the grid.
	for j in 0...@cols
        # Obtain the number of neighbors that exist around a current cell.
        neighbors = getNeighbors(i, j)

        # If the cell is currently live.
	if (@grid[i][j] == 1) 
          # A live cell with less than two live neighbors or more than three neighbors dies.
          if(neighbors < 2 || neighbors > 3)
	    temp[i][j] = 0
          end
          # A live cell with two or three live neighbors lives.
          if(neighbors == 2 || neighbors == 3)
            temp[i][j] = 1
          end

        # If the cell is currently dead.
	else
          #A dead cell with three live neighbors becomes live.
          if(neighbors == 3)
	    temp[i][j] = 1
          end
        end
      end
    end

    # Return the newly created grid for the user.
    @grid = temp
  end

  # Returns the number of neighbors for cell at @grid[i][j].
  def getNeighbors(_i, _j)
    # Variable for tracking the count of neighbors.
    neighbors = 0

    # Iterate through the rows.
    for x in -1..1
      # Iterate through the columns.
      for y in -1..1
        # Checks if surrounding cells are live.
        col = (_i + x + @cols) % @cols
        row = (_j + y + @rows) % @rows
        
        # If so, add to the neighbors count from the grid.
        neighbors = neighbors + @grid[col][row]
      end
    end
    # Do not count yourself in neighbors.
    neighbors -= @grid[_i][_j]
  end

  # Returns a string representation of GameOfLife object
  def to_s
    str = "\n"
    (0...@rows).each do |i|
      (0...@cols).each do |j|
        str += if (@grid[i][j]).zero?
                 ' . '
               else
                 ' X '
               end
      end
      str += "\n"
    end
    str
  end
end
