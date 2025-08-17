# Contains Game Logic
class Game
  attr_reader :board

  def initialize(board, black, white)
    @board = board
    @black = black
    @white = white
  end

  def black
    @black.pieces
  end

  def white
    @white.pieces
  end
end
