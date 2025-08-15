require_relative "piece"
# Represents Pawn in our Game
class Pawn < Piece
  def unicode
    "\u{265F}"
  end

  def get_possible_moves(board)
    # Moves
    # If pawn is at start THEN
    #   Move 2 steps
    # Else
    #   Move 1 step
    # END
  end

  def start?
    # Grab the pawn row index and its color
    # If pawn color is BLACK then
    #   its starting position is row 1
    # Else
    #   its starting position is row 6
    # END

    row_index = position.row
    start_pos =
      if color == BLACK_FOREGROUND
        1
      else
        6
      end

    # Now check if the pawn row index is same as the start index.
    # If yes then return true else return false
    row_index == start_pos
  end
end
