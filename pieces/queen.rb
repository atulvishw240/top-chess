require_relative "piece"
require_relative "../modules/mod_moves"
require_relative "../lib/board"
# Represents Queen in our Game
class Queen < Piece
  include Moves

  MOVES_DIR = [[1, 1], [1, -1], [-1, 1], [-1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def unicode
    "\u{265B}"
  end

  def get_possible_moves(board)
    all_possible_moves(MOVES_DIR, board)
  end
end
