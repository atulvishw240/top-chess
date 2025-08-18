# Contains Game Logic
class Game
  attr_reader :board, :black, :white

  def initialize(board, black, white)
    @board = board
    @black = black
    @white = white
  end

  def play
    setup
    selections = black.possible_selections(board)
    p selections
  end

  def setup
    setup_pieces_on_board(black)
    setup_pieces_on_board(white)
    board.display
  end

  def setup_pieces_on_board(set)
    set.pieces.each do |piece|
      board.update(piece, piece.position)
    end
  end

  # def black
  #   @black.pieces
  # end

  # def white
  #   @white.pieces
  # end
end
