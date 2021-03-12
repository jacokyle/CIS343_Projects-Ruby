require "minitest/autorun"
require "./GameOfLife"

#
# Unit tests for GameOfLife class (DO NOT MODIFY)
# Author: Nandigam
#
class GameOfLifeTest < Minitest::Test

    def test_constructor
        gol = GameOfLife.new()
        assert_equal(0, gol.rows)
        assert_equal(0, gol.cols)
        assert_equal("", gol.to_s.strip)
    end

    def test_grid_load_1
        gol = GameOfLife.new()
        gol.loadGrid("beacon.gol")
        assert_equal(6, gol.rows)
        assert_equal(6, gol.cols)
        expected = ".  .  .  .  .  . \n .  X  X  .  .  . \n .  X  X  .  .  . \n .  .  .  X  X  . \n .  .  .  X  X  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_grid_load_2
        gol = GameOfLife.new()
        gol.loadGrid("blinker.gol")
        assert_equal(5, gol.rows)
        assert_equal(5, gol.cols)
        expected = ".  .  .  .  . \n .  .  X  .  . \n .  .  X  .  . \n .  .  X  .  . \n .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_grid_load_3
        gol = GameOfLife.new()
        gol.loadGrid("glider.gol")
        assert_equal(9, gol.rows)
        assert_equal(9, gol.cols)
        expected = ".  .  .  .  .  .  .  .  . \n .  .  .  .  .  X  .  .  . \n .  .  .  X  .  X  .  .  . \n .  .  .  .  X  X  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_grid_load_4
        gol = GameOfLife.new()
        gol.loadGrid("toad.gol")
        assert_equal(6, gol.rows)
        assert_equal(6, gol.cols)
        expected = ".  .  .  .  .  . \n .  X  X  X  .  . \n X  X  X  .  .  . \n .  .  .  .  .  . \n .  .  .  .  .  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_grid_load_5
        gol = GameOfLife.new()
        gol.loadGrid("tub.gol")
        assert_equal(5, gol.rows)
        assert_equal(5, gol.cols)
        expected = ".  .  .  .  . \n .  X  .  .  . \n X  .  X  .  . \n .  X  .  .  . \n .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_grid_save_1
        gol = GameOfLife.new()
        gol.loadGrid("beacon.gol")
        gol.saveGrid("test.gol")
        actual = IO.read("test.gol").strip
        expected = "6 6 0 0 0 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 0 0 0"
        assert_equal(expected, actual)
    end

    def test_grid_save_2
        gol = GameOfLife.new()
        gol.loadGrid("blinker.gol")
        gol.saveGrid("test.gol")
        actual = IO.read("test.gol").strip
        expected = "5 5 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0"
        assert_equal(expected, actual)
    end

    def test_grid_save_3
        gol = GameOfLife.new()
        gol.loadGrid("glider.gol")
        gol.saveGrid("test.gol")
        actual = IO.read("test.gol").strip
        expected = "9 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
        assert_equal(expected, actual)
    end

    def test_grid_save_4
        gol = GameOfLife.new()
        gol.loadGrid("toad.gol")
        gol.saveGrid("test.gol")
        actual = IO.read("test.gol").strip
        expected = "6 6 0 0 0 0 0 0 0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
        assert_equal(expected, actual)
    end

    def test_grid_save_5
        gol = GameOfLife.new()
        gol.loadGrid("tub.gol")
        gol.saveGrid("test.gol")
        actual = IO.read("test.gol").strip
        expected = "5 5 0 0 0 0 0 0 1 0 0 0 1 0 1 0 0 0 1 0 0 0 0 0 0 0 0"
        assert_equal(expected, actual)
    end

    def test_number_of_neighbors
        gol = GameOfLife.new()
        gol.loadGrid("blinker.gol")
        assert_equal(0, gol.getNeighbors(0,0))
        assert_equal(1, gol.getNeighbors(1,2))
        assert_equal(2, gol.getNeighbors(2,2))
        assert_equal(1, gol.getNeighbors(3,2))
        assert_equal(0, gol.getNeighbors(0,4))
        assert_equal(0, gol.getNeighbors(4,0))
        assert_equal(0, gol.getNeighbors(4,4))
        assert_equal(1, gol.getNeighbors(0,2))
        assert_equal(0, gol.getNeighbors(2,0))
        assert_equal(0, gol.getNeighbors(2,4))
        assert_equal(1, gol.getNeighbors(4,2))
    end

    def test_mutate_1
        gol = GameOfLife.new()
        gol.loadGrid("beacon.gol")
        gol.mutate()
        expected = ".  .  .  .  .  . \n .  X  X  .  .  . \n .  X  .  .  .  . \n .  .  .  .  X  . \n .  .  .  X  X  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
        gol.mutate()
        expected = ".  .  .  .  .  . \n .  X  X  .  .  . \n .  X  X  .  .  . \n .  .  .  X  X  . \n .  .  .  X  X  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_mutate_2
        gol = GameOfLife.new()
        gol.loadGrid("blinker.gol")
        gol.mutate()
        expected = ".  .  .  .  . \n .  .  .  .  . \n .  X  X  X  . \n .  .  .  .  . \n .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
        gol.mutate()
        expected = ".  .  .  .  . \n .  .  X  .  . \n .  .  X  .  . \n .  .  X  .  . \n .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_mutate_3
        gol = GameOfLife.new()
        gol.loadGrid("glider.gol")
        gol.mutate()
        expected = ".  .  .  .  .  .  .  .  . \n .  .  .  .  X  .  .  .  . \n .  .  .  .  .  X  X  .  . \n .  .  .  .  X  X  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
        gol.mutate()
        expected = ".  .  .  .  .  .  .  .  . \n .  .  .  .  .  X  .  .  . \n .  .  .  .  .  .  X  .  . \n .  .  .  .  X  X  X  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  . \n .  .  .  .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_mutate_4
        gol = GameOfLife.new()
        gol.loadGrid("toad.gol")
        gol.mutate()
        expected = ".  .  X  .  .  . \n X  .  .  X  .  . \n X  .  .  X  .  . \n .  X  .  .  .  . \n .  .  .  .  .  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
        gol.mutate()
        expected = ".  .  .  .  .  . \n .  X  X  X  .  . \n X  X  X  .  .  . \n .  .  .  .  .  . \n .  .  .  .  .  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
        gol.mutate()
        expected = ".  .  X  .  .  . \n X  .  .  X  .  . \n X  .  .  X  .  . \n .  X  .  .  .  . \n .  .  .  .  .  . \n .  .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

    def test_mutate_5
        gol = GameOfLife.new()
        gol.loadGrid("tub.gol")
        gol.mutate()
        expected = ".  .  .  .  . \n .  X  .  .  . \n X  .  X  .  . \n .  X  .  .  . \n .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
        gol.mutate()
        expected = ".  .  .  .  . \n .  X  .  .  . \n X  .  X  .  . \n .  X  .  .  . \n .  .  .  .  ."
        assert_equal(expected, gol.to_s.strip)
    end

end
