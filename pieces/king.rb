require_relative "piece"
require_relative "../modules/mod_move"
# Represents King
class King < Piece
  include Move

  # [top_left, front, top_right, left, right, bottom_left, down, bottom_right]
  MOVES_DIR = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  def unicode
    "\u{265A}"
  end

  def get_possible_moves(board)
    all_possible_moves(MOVES_DIR, board)
  end
end
