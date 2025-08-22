require_relative "square"
require_relative "../modules/constants"
# Handle Game Effect on Board
class Board
  include Constants

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

  def update(piece, new_position)
    # Piece position gets updated
    # Place piece on new square
    # For the old position mark it as empty
    prev_position = piece.position
    prev_square = get_square(prev_position)
    prev_square.piece = EMPTY

    piece.position = new_position
    square = get_square(new_position)
    square.piece = piece
  end

  def remove(piece_or_marker)
    position = piece_or_marker.position
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
