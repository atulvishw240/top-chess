require_relative "square"
# Handle Game Effect on Board
class Board
  attr_accessor :board, :black, :white

  def initialize(black, white)
    @black = black
    @white = white
    @board = Array.new(8) { Array.new(8) { Square.new } }
    assign_color_to_squares
    setup(black, white)
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

  def setup(black, white)
    black.each do |piece|
      update(piece, piece.position)
    end

    white.each do |piece|
      update(piece, piece.position)
    end
  end
end
