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
    setup_board
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

  def update(update_with, new_position)
    square = get_square(new_position)
    square.piece = update_with
  end

  def contains_piece?(position)
    square = get_square(position)
    square.contains_piece?
  end

  def get_piece(position)
    square = get_square(position)
    square.piece
  end

  def delete_piece(position)
    piece = get_piece(position)
    color = piece.color
    pieces = pieces_set(color)
    pieces.delete(piece)

    update(EMPTY, position)
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

  def pawns(color)
    pawns = []
    pieces = pieces_set(color)
    pieces.each do |piece|
      pawns << piece if piece.is_a?(Pawn)
    end

    pawns
  end

  def assign_color_to_square(position, color)
    square = get_square(position)
    square.color = color
  end

  # --------------  PRIVATE METHODS  -------------------

  def color(position)
    sum = position.row + position.col

    if sum.even?
      Constants::WHITE_BACKGROUND
    else
      Constants::CYAN_BACKGROUND
    end
  end

  def get_square(position)
    row_index = position.row
    col_index = position.col

    board[row_index][col_index]
  end

  def setup_board
    assign_color_to_squares
    setup_pieces_on_board
  end

  def assign_color_to_squares
    board.each_with_index do |row, row_index|
      row.each_with_index do |_, col_index|
        position = Position.new(row_index, col_index)
        assign_color_to_square(position, color(position))
      end
    end
  end

  def setup_pieces_on_board
    pieces_set = [dark_pieces, light_pieces]
    pieces_set.each do |dark_or_light_pieces|
      dark_or_light_pieces.each do |piece|
        update(piece, piece.position)
      end
    end
  end
end
