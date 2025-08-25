require_relative "square"
require_relative "../modules/constants"
# Handle Game Effect on Board
class Board
  include Constants

  attr_accessor :board, :pieces

  def initialize(pieces)
    @board = Array.new(8) { Array.new(8) { Square.new } }
    @pieces = pieces
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

  def delete_piece(position)
    pieces.each do |piece|
      next unless position == piece.position

      update_square(EMPTY, piece.position)
      pieces.delete(piece)
    end
  end

  def possible_pieces_selection(color)
    selections = []
    pieces.each do |piece|
      next unless same_color?(piece, color)

      selections << possible_piece_selection(piece)
    end

    selections.compact # remove nil
  end

  def king(color)
    pieces.each do |piece|
      return piece if same_color_king?(piece, color)
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

  def possible_piece_selection(piece)
    all_possible_moves = piece.get_possible_moves(self)

    return nil if all_possible_moves.empty?

    position = piece.position
    row_index = position.row
    col_index = position.col
    [row_index, col_index]
  end

  def same_color?(piece, color)
    piece.color == color
  end

  def same_color_king?(piece, color)
    same_color?(piece, color) && piece.is_a?(King)
  end
end
