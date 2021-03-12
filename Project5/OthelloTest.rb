require "minitest/autorun"
require "./Othello"

#
# Unit tests for Othello class (DO NOT MODIFY)
# Author: Nandigam
#
class OthelloTest < Minitest::Test

    def test_constructor_1
        game = Othello.new(4, 1, 'B')
        assert_equal(4, game.size)
        assert_equal(1, game.turn)
        assert_equal(Othello::BLACK, game.disc)
        assert_equal(Othello::BLACK, game.p1Disc)
        assert_equal(Othello::WHITE, game.p2Disc)
        expected = "1 2 3 4 \n1 - - - -\n2 - B W -\n3 - W B -\n4 - - - -"
        assert_equal(expected, game.to_s.strip)
    end

    def test_constructor_2
        game = Othello.new(6, 1, 'B')
        assert_equal(6, game.size)
        assert_equal(1, game.turn)
        assert_equal(Othello::BLACK, game.disc)
        assert_equal(Othello::BLACK, game.p1Disc)
        assert_equal(Othello::WHITE, game.p2Disc)
        expected = "1 2 3 4 5 6 \n1 - - - - - -\n2 - - - - - -\n3 - - B W - -\n4 - - W B - -\n5 - - - - - -\n6 - - - - - -"
        assert_equal(expected, game.to_s.strip)
    end

    def test_constructor_3
        game = Othello.new(8, 2, 'W')
        assert_equal(8, game.size)
        assert_equal(2, game.turn)
        assert_equal(Othello::WHITE, game.disc)
        assert_equal(Othello::BLACK, game.p1Disc)
        assert_equal(Othello::WHITE, game.p2Disc)
        expected = "1 2 3 4 5 6 7 8 \n1 - - - - - - - -\n2 - - - - - - - -\n3 - - - - - - - -\n4 - - - B W - - -\n5 - - - W B - - -\n6 - - - - - - - -\n7 - - - - - - - -\n8 - - - - - - - -"
        assert_equal(expected, game.to_s.strip)
    end

    def test_isGameOver
        game = Othello.new(4, 1, 'B')
        assert_equal(false, game.isGameOver())
    end

    def test_isBoardFull_1
        game = Othello.new(4, 1, 'B')
        assert_equal(false, game.isBoardFull())
    end

    def test_isBoardFull_2
        game = Othello.new(4, 1, 'B')
        game.placeDiscAt(1,3)
        game.placeDiscAt(0,3)
        game.placeDiscAt(0,2)
        game.placeDiscAt(0,1)
        game.placeDiscAt(3,0)
        game.placeDiscAt(3,2)
        game.placeDiscAt(1,0)
        game.placeDiscAt(2,0)
        game.placeDiscAt(3,1)
        game.placeDiscAt(3,3)
        game.prepareNextTurn()
        game.placeDiscAt(0,0)
        game.prepareNextTurn()
        game.placeDiscAt(2,3)
        assert_equal(true, game.isBoardFull())
    end

    def test_isValidMove_1
        game = Othello.new(4, 1, 'B')
        assert_equal(false, game.isValidMove(0,0))
        assert_equal(false, game.isValidMove(0,3))
        assert_equal(false, game.isValidMove(3,0))
        assert_equal(false, game.isValidMove(3,3))
        assert_equal(false, game.isValidMove(0,1))
        assert_equal(false, game.isValidMove(1,0))
        assert_equal(false, game.isValidMove(2,3))
        assert_equal(false, game.isValidMove(3,2))
    end

    def test_isValidMove_2
        game = Othello.new(4, 1, 'W')
        assert_equal(false, game.isValidMove(0,0))
        assert_equal(false, game.isValidMove(0,2))
        assert_equal(false, game.isValidMove(0,3))
        assert_equal(false, game.isValidMove(1,3))
        assert_equal(false, game.isValidMove(2,0))
        assert_equal(false, game.isValidMove(3,0))
        assert_equal(false, game.isValidMove(3,1))
        assert_equal(false, game.isValidMove(3,3))
    end

    def test_isValidMove_3
        game = Othello.new(4, 1, 'B')
        assert_equal(true, game.isValidMove(0,2))
        assert_equal(true, game.isValidMove(1,3))
        assert_equal(true, game.isValidMove(2,0))
        assert_equal(true, game.isValidMove(3,1))
    end

    def test_isValidMove_4
        game = Othello.new(4, 1, 'W')
        assert_equal(true, game.isValidMove(0,1))
        assert_equal(true, game.isValidMove(1,0))
        assert_equal(true, game.isValidMove(2,3))
        assert_equal(true, game.isValidMove(3,2))
    end

    def test_isValidMoveAvailable_1
        game = Othello.new(4, 1, 'W')
        assert_equal(true, game.isValidMoveAvailable())
    end

    def test_isValidMoveAvailable_2
        game = Othello.new(4, 1, 'B')
        assert_equal(true, game.isValidMoveAvailable())
    end

    def test_isValidMoveAvailable_3
        game = Othello.new(4, 1, 'B')
        game.placeDiscAt(1,3)
        game.placeDiscAt(0,3)
        game.placeDiscAt(0,2)
        game.placeDiscAt(0,1)
        game.placeDiscAt(3,0)
        game.placeDiscAt(3,2)
        game.placeDiscAt(1,0)
        game.placeDiscAt(2,0)
        game.placeDiscAt(3,1)
        game.placeDiscAt(3,3)
        game.prepareNextTurn()
        game.placeDiscAt(0,0)
        game.prepareNextTurn()
        game.placeDiscAt(2,3)
        assert_equal(false, game.isValidMoveAvailable())
    end

    def test_4_x_4_board_play
        game = Othello.new(4, 1, 'B')
        game.placeDiscAt(1,3)
        game.placeDiscAt(0,3)
        game.placeDiscAt(0,2)
        game.placeDiscAt(0,1)
        game.placeDiscAt(3,0)
        game.placeDiscAt(3,2)
        game.placeDiscAt(1,0)
        game.placeDiscAt(2,0)
        game.placeDiscAt(3,1)
        game.placeDiscAt(3,3)
        game.prepareNextTurn()
        game.placeDiscAt(0,0)
        game.prepareNextTurn()
        game.placeDiscAt(2,3)
        assert_equal(true, game.isGameOver())
        assert_equal(Othello::WHITE, game.checkWinner())
    end

    def test_6_x_6_board_play
        game = Othello.new(6, 2, 'W')
        game.placeDiscAt(2,1)
        game.placeDiscAt(1,3)
        game.placeDiscAt(2,4)
        game.placeDiscAt(3,5)
        game.placeDiscAt(4,4)
        game.placeDiscAt(2,0)
        game.placeDiscAt(1,1)
        game.placeDiscAt(0,1)
        game.placeDiscAt(0,0)
        game.placeDiscAt(4,1)
        game.placeDiscAt(2,5)
        game.placeDiscAt(4,3)
        game.placeDiscAt(4,2)
        game.placeDiscAt(4,5)
        game.placeDiscAt(5,5)
        game.placeDiscAt(1,2)
        game.placeDiscAt(4,0)
        game.placeDiscAt(5,3)
        game.placeDiscAt(1,4)
        game.placeDiscAt(0,3)
        game.placeDiscAt(0,2)
        game.placeDiscAt(5,0)
        game.placeDiscAt(3,1)
        game.placeDiscAt(0,5)
        game.placeDiscAt(3,4)
        game.placeDiscAt(5,4)
        game.placeDiscAt(5,1)
        game.placeDiscAt(1,0)
        game.placeDiscAt(0,4)
        game.placeDiscAt(5,2)
        game.placeDiscAt(3,0)
        game.prepareNextTurn()
        game.placeDiscAt(1,5)
        assert_equal(true, game.isGameOver())
        assert_equal(Othello::WHITE, game.checkWinner())
    end

    def test_8_x_8_board_play
        game = Othello.new(8, 1, 'B')
        game.placeDiscAt(5,3)
        game.placeDiscAt(5,2)
        game.placeDiscAt(3,5)
        game.placeDiscAt(2,5)
        game.placeDiscAt(4,2)
        game.placeDiscAt(3,6)
        game.placeDiscAt(3,7)
        game.placeDiscAt(3,2)
        game.placeDiscAt(1,6)
        game.placeDiscAt(0,7)
        game.placeDiscAt(4,1)
        game.placeDiscAt(5,4)
        game.placeDiscAt(6,3)
        game.placeDiscAt(6,2)
        game.placeDiscAt(6,1)
        game.placeDiscAt(7,2)
        game.placeDiscAt(7,1)
        game.placeDiscAt(2,3)
        game.placeDiscAt(3,1)
        game.placeDiscAt(2,4)
        game.placeDiscAt(6,5)
        game.placeDiscAt(6,0)
        game.placeDiscAt(1,4)
        game.placeDiscAt(2,6)
        game.placeDiscAt(7,3)
        game.placeDiscAt(5,5)
        game.placeDiscAt(4,5)
        game.placeDiscAt(4,6)
        game.placeDiscAt(4,7)
        game.placeDiscAt(2,0)
        game.placeDiscAt(5,1)
        game.placeDiscAt(6,4)
        game.placeDiscAt(3,0)
        game.placeDiscAt(2,2)
        game.placeDiscAt(1,2)
        game.placeDiscAt(5,6)
        game.placeDiscAt(5,7)
        game.placeDiscAt(0,2)
        game.placeDiscAt(2,7)
        game.placeDiscAt(6,6)
        game.placeDiscAt(7,4)
        game.placeDiscAt(7,5)
        game.placeDiscAt(6,7)
        game.placeDiscAt(7,0)
        game.placeDiscAt(0,6)
        game.placeDiscAt(5,0)
        game.placeDiscAt(4,0)
        game.placeDiscAt(7,6)
        game.placeDiscAt(2,1)
        game.placeDiscAt(1,5)
        game.placeDiscAt(1,3)
        game.placeDiscAt(7,7)
        game.placeDiscAt(0,5)
        game.placeDiscAt(1,7)
        game.placeDiscAt(0,3)
        game.placeDiscAt(0,4)
        game.placeDiscAt(1,0)
        game.placeDiscAt(0,1)
        game.placeDiscAt(1,1)
        game.placeDiscAt(0,0)
        assert_equal(true, game.isGameOver())
        assert_equal(Othello::WHITE, game.checkWinner())
    end

end
