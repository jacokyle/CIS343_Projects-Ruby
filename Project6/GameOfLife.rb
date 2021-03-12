#
#  Game of Life class
#
#  Author(s): Your Name(s)
#
class GameOfLife

    # Creates getter methods for instance variables @rows and @cols
    attr_reader  :rows, :cols

    # Constructor that initializes instance variables with default values
    def initialize()
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

        #
        # TO DO: setup @grid as array of arrays and fill it with values from the tokens array
        #
    end

    # Saves the current grid values to the file specified
    def saveGrid(file)
        data = @rows.to_s + ' ' + @cols.to_s

        #
        # TO DO: append the values in @grid to data
        #

        data += "\n"
        IO.write(file, data)
    end

    # Mutates the grid to next generation
    def mutate()
        # make a copy of grid and fill it with zeros
        temp = Array.new(@rows)
        for i in (0...@rows)
            temp[i] = Array.new(@cols)
            temp[i].fill(0)
        end

        #
        # TO DO: set values in temp grid to next generation
        # 

        # DO NOE DELETE: set @grid to temp grid
        @grid = temp
    end

    # Returns the number of neighbors for cell at @grid[i][j]
    def getNeighbors(i, j)
        neighbors = 0

        #
        # TO DO: determine number of neighbors of cell at @grid[i][j]
        #

        # DO NOT DELETE THE LINE BELOW
        neighbors
    end

    # Returns a string representation of GameOfLife object
    def to_s
        str = "\n"
        for i in 0...@rows
            for j in 0...@cols
                if @grid[i][j] == 0
                    str += ' . '
                else
                    str += ' X '
                end
            end
            str += "\n"
        end
        str
    end

end
