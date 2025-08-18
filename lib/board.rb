require_relative "square"
require_relative "ansi_codes"
# Handle Game Effect on Board
class Board
  include ANSI

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { Square.new } }
    assign_color_to_squares
  end

  def display
    board.each do |row|
      row.each do |square|
        print square
      end

      puts ""
    end
  end

  def update(piece_or_marker, position)
    square = get_square(position)
    square.piece = piece_or_marker
  end

  def delete_piece_or_marker(position)
    square = get_square(position)
    square.piece = EMPTY
  end

  def contains_piece?(position)
    square = get_square(position)
    square.contains_piece?
  end

  def get_piece(position)
    square = get_square(position)
    square.piece
  end

  # --------------  PRIVATE METHODS  -------------------
  def assign_color_to_squares
    board.each_with_index do |row, row_index|
      row.each_with_index do |square, col_index|
        square.assign_color(row_index, col_index)
      end
    end
  end

  def get_square(position)
    row_index = position.row
    col_index = position.col

    board[row_index][col_index]
  end
end
