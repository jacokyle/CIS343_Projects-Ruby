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
    data = IO.read(file)
    tokens = data.strip.split(' ')

    @rows = tokens.shift.to_i
    @cols = tokens.shift.to_i

    @grid = Array(@rows)

    for i in 0...@rows do 
      @grid[i] = Array.new(@cols)
      @grid[i].fill(0)
    end

    values = 0 

    for i in 0...@rows do
      for j in 0...@cols do
        @grid[i][j] = tokens[values].to_i
        values += 1
      end
    end
  end

  # Saves the current grid values to the file specified
  def saveGrid(file)
    data = "#{@rows} #{@cols}"

    for i in (0...@rows) 
			for j in (0...@cols) 
				data += ' '
				data += @grid[i][j].to_s
      end
    end

    data += "\n"
    IO.write(file, data)
  end

  # Mutates the grid to next generation
  def mutate
    # make a copy of grid and fill it with zeros
    temp = Array.new(@rows)
    (0...@rows).each do |i|
      temp[i] = Array.new(@cols)
      temp[i].fill(0)
    end

		for i in 0...@rows
			for j in 0...@cols
        neighbors = getNeighbors(i, j)

				if (@grid[i][j] == 1) 
          if(neighbors < 2 || neighbors > 3)
				    temp[i][j] = 0
          end
          if(neighbors == 2 || neighbors == 3)
					  temp[i][j] = 1
          end
        
				else
          if(neighbors == 3)
					  temp[i][j] = 1
          end
        end
			end
		end

    # DO NOT DELETE: set @grid to temp grid
    @grid = temp
  end

  # Returns the number of neighbors for cell at @grid[i][j]
  def getNeighbors(_i, _j)
    neighbors = 0

		for x in -1..1
			for y in -1..1
        col = (_i + x + @cols) % @cols
        row = (_j + y + @rows) % @rows
        
        neighbors = neighbors + @grid[col][row]
			end
		end
		neighbors -= @grid[_i][_j]

    # DO NOT DELETE THE LINE BELOW
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
