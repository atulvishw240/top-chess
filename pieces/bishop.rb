require_relative "piece"
require_relative "../lib/calculate_moves"
# Represents Bishop in Our Game
class Bishop < Piece
  include CalcMoves

  MOVES_DIR = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # [upper right, upper left, lower right, lower left]

  def unicode
    "\u{265D}"
  end

  def get_possible_moves(board)
    all_possible_moves(MOVES_DIR, board)
  end
end
