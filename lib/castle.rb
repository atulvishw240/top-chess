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

  def castling_moves(board, color)
    moves = []
    king = board.king(color)
    position = king.position

    if castling?(board, color)
      moves << Position.new(position.row, position.col + 2) if king_side

      moves << Position.new(position.row, position.col - 2) if queen_side
    end

    moves
  end

  def castling?(board, color)
    king_side_castling(board, color)
    queen_side_castling(board, color)

    queen_side || king_side
  end

  def king_side_castling(board, color)
    boolean = castle(board, color, :king)
    self.king_side = boolean
  end

  def queen_side_castling(board, color)
    boolean = castle(board, color, :queen)
    self.queen_side = boolean
  end

  def castle(board, color, side)
    # Browse wikipedia to know
    first = first_rule(board, color, side)
    second = second_rule(board, color)
    third = third_rule(board, color, side)
    fourth = fourth_rule(board, color, side)
    first && second && third && fourth
  end

  def first_rule(board, color, side)
    king = board.king(color)
    rook = rook(board, color, side)
    !ever_moved?(king) && !ever_moved?(rook)
  end

  def second_rule(board, color)
    !rules.check?(board, color)
  end

  def third_rule(board, color, side)
    king = board.king(color)
    number = no_of_squares_between_king_and_rook(side)
    position = king.position

    number.times do
      position = right_or_left(position, direction(side))
      return false if board.contains_piece?(position)
    end

    true
  end

  def fourth_rule(board, color, side)
    opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    king = board.king(color)
    position = king.position

    2.times do
      position = right_or_left(position, direction(side))
      return false if opponent_moves.include?(position)
    end

    true
  end

  def ever_moved?(piece)
    return true if piece == EMPTY

    piece.has_moved
  end

  def rook(board, color, side)
    if side == :king
      king_side_rook(board, color)
    else
      queen_side_rook(board, color)
    end
  end

  def no_of_squares_between_king_and_rook(side)
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
