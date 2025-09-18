require_relative 'chess_rules'
require_relative '../modules/constants'
require_relative '../pieces/king'
require_relative '../pieces/rook'
require_relative '../lib/board'
# Handles Castling of King
class Castle
  include Constants

  attr_accessor :queen_side, :king_side, :rules

  def initialize
    @queen_side = false
    @king_side = false
    @rules = ChessRules.new
  end

  def castling?(board, color)
    king_side_castling(board, color)
    queen_side_castling(board, color)

    queen_side || king_side
  end

  def king_side_castling(board, color)
    king = board.king(color)
    return if king.has_moved || rules.check?(board, color)

    rook = rook(board, color, :king)
    return if rook == EMPTY || rook.has_moved

    opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    position = king.position
    no_of_empty_squares_between_king_and_rook(:king).times do
      position = right_or_left(position, :right)
      return if board.contains_piece?(position)
    end

    position = king.position
    2.times do
      position = right_or_left(position, :right)
      return if opponent_moves.include?(position)
    end

    self.king_side = true
  end

  def queen_side_castling(board, color)
    king = board.king(color)
    return if king.has_moved || rules.check?(board, color)

    rook = rook(board, color, :queen)
    return if rook == EMPTY || rook.has_moved

    opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    position = king.position
    no_of_empty_squares_between_king_and_rook(:queen).times do
      position = right_or_left(position, :left)
      return if board.contains_piece?(position)
    end

    position = king.position
    2.times do
      position = right_or_left(position, :left)
      return if opponent_moves.include?(position)
    end

    self.queen_side = true
  end

  def rook(board, color, side)
    if side == :king
      king_side_rook(board, color)
    else
      queen_side_rook(board, color)
    end
  end

  def no_of_empty_squares_between_king_and_rook(side)
    if side == :king
      2
    else
      3
    end
  end

  def right_or_left(position, direction)
    row_index = position.row
    col_index = position.col

    if direction == :right
      Position.new(row_index, col_index + 1)
    else
      Position.new(row_index, col_index - 1)
    end
  end

  def king_side_rook(board, color)
    position =
      if color == BLACK_FOREGROUND
        Position.new(0, 7)
      else
        Position.new(7, 7)
      end

    board.get_piece(position)
  end

  def queen_side_rook(board, color)
    position =
      if color == BLACK_FOREGROUND
        Position.new(0, 0)
      else
        Position.new(7, 0)
      end

    board.get_piece(position)
  end
end
