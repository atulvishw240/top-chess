require_relative '../modules/constants'
# Handle pawn promotion
class Promotion
  include Constants

  def promotion?(piece, move)
    if piece.is_a?(Pawn)
      color = piece.color
      rank = move.row
      return (color == BLACK_FOREGROUND && rank == 7) ||
             (color == BROWN_FOREGROUND && rank.zero?)
    end

    false
  end
end
