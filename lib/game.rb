# Contains Game Logic
class Game
  attr_reader :board, :black, :white

  def initialize(board, black, white)
    @board = board
    @black = black
    @white = white
  end
end
