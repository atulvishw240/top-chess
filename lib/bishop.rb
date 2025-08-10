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
      moves += calculate_moves_for_one_diagonal(board, diagonal)
    end

    moves
  end

  def calculate_moves_for_one_diagonal(board, diagonal) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    moves = []

    row_index = diagonal[0] + position.row
    col_index = diagonal[1] + position.col
    position = Position.new(row_index, col_index)

    while position.valid?
      move = [row_index, col_index]

      if board.contains_piece?(position)
        piece = board.get_piece(position)
        moves << move unless piece.color == color
        break
      end

      moves << move

      row_index += diagonal[0]
      col_index += diagonal[1]
      position = Position.new(row_index, col_index)
    end

    moves
  end

  def to_s
    "#{color}#{unicode} #{RESET_TERMINAL}"
  end
end
