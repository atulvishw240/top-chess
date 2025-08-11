require_relative "piece"
require_relative "../lib/calculate_moves"

# Represents Rook
class Rook < Piece
  include CalcMoves

  # [front, back, right, left]
  MOVES_DIR = [[-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def unicode
    "\u{265C}"
  end

  def all_possible_moves(board)
    moves = []

    MOVES_DIR.each do |dir|
      moves += calculate_moves_in_one_dir(board, dir)
    end

    moves
  end
end
