require_relative "piece"
# Represents Queen in our Game
class Queen < Piece
  MOVES_DIR = [[1, 1], [1, -1], [-1, 1], [-1, -1], [-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def unicode
    "\u{265B}"
  end
end
