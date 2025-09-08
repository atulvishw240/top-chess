require_relative 'piece'
require_relative '../modules/mod_moves'

# Represents Rook
class Rook < Piece
  include Moves

  # [front, back, right, left]
  MOVES_DIR = [[-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def unicode
    "\u{265C}"
  end

  def get_possible_moves(board)
    all_possible_moves(MOVES_DIR, board)
  end
end
