require_relative 'square'
require_relative '../modules/constants'
# Handle Game Effect on Board
class Board
  include Constants

  attr_accessor :board, :dark_pieces, :light_pieces

  def initialize(dark, light)
    @board = Array.new(8) { Array.new(8) { Square.new } }
    @dark_pieces = dark
    @light_pieces = light
    assign_color_to_squares
  end

  def display
    board.each_with_index do |row, row_index|
      print "#{8 - row_index} "
      row.each do |square|
        print square
      end

      puts ''
    end

    puts '  a b c d e f g h'
  end

  def update(piece, new_position)
    prev_position = piece.position
    update_square(EMPTY, prev_position)
    piece.position = new_position
    update_square(piece, new_position)
  end

  def contains_piece?(position)
    square = get_square(position)
    square.contains_piece?
  end

  def get_piece(position)
    square = get_square(position)
    square.piece
  end

  def add_piece(piece, position)
    piece.position = position
    pieces << piece
    update(piece, position)
  end

  def delete_piece(position)
    piece = get_piece(position)
    color = piece.color
    pieces = pieces_set(color)
    pieces.delete(piece)

    update_square(EMPTY, position)
  end

  def pieces_set(color)
    if color == BLACK_FOREGROUND
      dark_pieces
    else
      light_pieces
    end
  end

  def king(color)
    pieces = pieces_set(color)
    pieces.each do |piece|
      return piece if piece.color == color && piece.is_a?(King)
    end
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

  def update_square(update_with, position)
    square = get_square(position)
    square.piece = update_with
  end
end
