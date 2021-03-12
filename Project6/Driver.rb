require "./GameOfLife"

#
# Driver code for Game of Life game (DO NOT MODIFY)
# Author(s): Nandigam
#

def main
    # ARGV array stores command-line arguments
    if ARGV.length != 1
        puts("Incorrect number of arguments to the program")
        puts("Usage: ruby Main.rb inputfile")
        puts("Example: ruby Main.rb blinker.gol")
        exit(1)
    end

    # instantiate GameOfLife object
    gol = GameOfLife.new()

    # load grid with data from file given on command line
    gol.loadGrid(ARGV.shift.strip)

    puts("Beginning with grid size " + gol.rows.to_s + "," + gol.cols.to_s)
    puts(gol.to_s)

    # play game
    while true
        puts("\nPress n (or return) for next generation, i to iterate multiple times,")
        print("w to save grid to disk, or q to quit? ")
        line = gets.strip

        case line
            when 'n', ''
                gol.mutate()
                puts(gol.to_s)

            when 'i'
                print("How many iterations? ")
                num = gets.strip.to_i
                for i in (0...num)
                    gol.mutate()
                    puts(gol.to_s)
                end

            when 'w'
                print("Enter a filename: ")
                filename = gets.strip
                gol.saveGrid(filename)
                puts("Grid saved to file " + filename + "\n")

            when 'q'
                puts("Exiting program")
                exit(0)
        end
    end
end

# Invoke the driver
main()
