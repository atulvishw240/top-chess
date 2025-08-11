require_relative "piece"
require_relative "../lib/calculate_moves"
require_relative "../lib/board"
# Represents Queen in our Game
class Queen < Piece
  include CalcMoves

  MOVES_DIR = [[1, 1], [1, -1], [-1, 1], [-1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def unicode
    "\u{265B}"
  end

  def all_possible_moves(board)
    moves = []

    MOVES_DIR.each do |diagonal|
      moves += calculate_moves_in_one_dir(board, diagonal)
    end

    moves
  end
end
