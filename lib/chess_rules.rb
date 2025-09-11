require_relative '../modules/constants'
# Contains game logic for our chess
class ChessRules
  include Constants

  def check?(board, color)
    pieces = board.pieces_set(opponent_color(color))
    moves = []
    pieces.each { |piece| moves += piece.get_possible_moves(board) }
    king = board.king(color)
    moves.any? { |move| move == king.position }
  end

  def opponent_color(color)
    color == BLACK_FOREGROUND ? BROWN_FOREGROUND : BLACK_FOREGROUND
  end
end
