# Contains Game Logic
class Game
  attr_accessor :board, :black, :white

  def initialize(board, black, white)
    @board = board
    @black = black
    @white = white
  end
end
