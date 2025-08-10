require_relative "ansi_codes"
require_relative "position"
require_relative "piece"
# Represents Bishop in Our Game
class Bishop < Piece
  include ANSI

  attr_accessor :position
  attr_reader :color, :unicode

  DIAGONALS_DIR = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze # [upper right, upper left, lower right, lower left]

  def initialize(color)
    @color = color
    @unicode = "\u{265D}"
  end

  def all_possible_moves(board)
    moves = []

    DIAGONALS_DIR.each do |diagonal|
      calculate_moves_for_one_diagonal(moves, diagonal)
    end

    moves
  end

  def calculate_moves_for_one_diagonal(moves, diagonal)
    row_index = position.row
    col_index = position.col

    loop do
      row_index += diagonal[0]
      col_index += diagonal[1]

      break unless Position.new(row_index, col_index).valid?

      moves << [row_index, col_index]
    end
  end

  def to_s
    "#{color}#{unicode} #{RESET_TERMINAL}"
  end
end
