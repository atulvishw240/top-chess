require_relative 'chess_rules'
require_relative '../modules/constants'

class Castle
  include Constants

  attr_accessor :rules

  def initialize
    @rules = ChessRules.new
  end

  def king_side_castling(board, color)
    king = board.king(color)
    return false if king.has_moved || rules.check?(board, color)

    rook = king_side_rook(board, color)
    return false if rook == EMPTY || rook.has_moved

    opponent_moves = rules.all_possible_moves_for_opponent(board, color)
    position = king.position
    2.times do
      position = Position.new(position.row, position.col + 1)
      return false if board.contains_piece?(position) || opponent_moves.include?(position)
    end

    true
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
end
