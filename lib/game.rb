# Contains Game Logic
class Game
  attr_reader :board

  def initialize(board, black, white)
    @board = board
    @black = black
    @white = white
  end

  def setup
    setup_pieces_on_board(black)
    setup_pieces_on_board(white)
    board.display
  end

  def setup_pieces_on_board(set)
    set.each do |piece|
      board.update(piece, piece.position)
    end
  end

  def black
    @black.pieces
  end

  def white
    @white.pieces
  end
end
