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
    @queen_side = true
    @king_side = true
    @rules = ChessRules.new
  end

  def castling?(board, color)
    king_side_castling(board, color)
    queen_side_castling(board, color)

    queen_side || king_side
  end

  def king_side_castling(board, color)
    # king = board.king(color)
    # return if king.has_moved || rules.check?(board, color)

    # rook = rook(board, color, :king)
    # return if rook == EMPTY || rook.has_moved

    # opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    # position = king.position
    # no_of_empty_squares_between_king_and_rook(:king).times do
    #   position = right_or_left(position, :right)
    #   return if board.contains_piece?(position)
    # end

    # position = king.position
    # 2.times do
    #   position = right_or_left(position, :right)
    #   return if opponent_moves.include?(position)
    # end

    boolean = castle(board, color, :king)
    # return if boolean.nil?

    self.king_side = boolean
  end

  def queen_side_castling(board, color)
    # king = board.king(color)
    # return if king.has_moved || rules.check?(board, color)

    # rook = rook(board, color, :queen)
    # return if rook == EMPTY || rook.has_moved

    # opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    # position = king.position
    # no_of_empty_squares_between_king_and_rook(:queen).times do
    #   position = right_or_left(position, :left)
    #   return if board.contains_piece?(position)
    # end

    # position = king.position
    # 2.times do
    #   position = right_or_left(position, :left)
    #   return if opponent_moves.include?(position)
    # end

    boolean = castle(board, color, :queen)
    # return if boolean.nil?

    self.queen_side = boolean
  end

  # side is a symbol
  def castle(board, color, side)
    king = board.king(color)
    return false if king.has_moved || rules.check?(board, color)

    rook = rook(board, color, side)
    return false if rook == EMPTY || rook.has_moved

    opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    position = king.position
    no_of_empty_squares_between_king_and_rook(side).times do
      position = right_or_left(position, direction(side))
      return false if board.contains_piece?(position)
    end

    position = king.position
    2.times do
      position = right_or_left(position, direction(side))
      return false if opponent_moves.include?(position)
    end

    true
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

  def direction(side)
    hash = { king: :right, queen: :left }
    hash[side]
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
