require_relative "ansi_codes"
require_relative "position"
require_relative "piece"
require_relative "board"

# Represents Rook
class Rook
  attr_accessor :position
  attr_reader :color, :unicode

  # [front, back, right, left]
  MOVES_DIR = [[-1, 0], [1, 0], [0, 1], [0, -1]].freeze

  def initialize(color)
    @color = color
    @unicode = "\u{265C}"
  end

  def all_possible_moves(board)
    moves = []

    MOVES_DIR.each do |dir|
      moves += calculate_moves_in_one_dir(board, dir)
    end

    moves
  end

  def calculate_moves_in_one_dir(board, dir) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    moves = []

    row_index = dir[0] + position.row
    col_index = dir[1] + position.col
    position = Position.new(row_index, col_index)

    while position.valid?
      move = [row_index, col_index]

      if board.contains_piece?(position)
        piece = board.get_piece(position)
        moves << move unless piece.color == color
        break
      end

      moves << move

      row_index += dir[0]
      col_index += dir[1]
      position = Position.new(row_index, col_index)
    end

    moves
  end
end
