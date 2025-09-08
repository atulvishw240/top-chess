require_relative 'piece'
require_relative '../modules/mod_move'
# Represents Knight in Our Game
class Knight < Piece
  include Move

  MOVES_DIR = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1]].freeze

  def unicode
    "\u{265E}"
  end

  def get_possible_moves(board)
    all_possible_moves(MOVES_DIR, board)
  end
end
