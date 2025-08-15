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
    row_index = position.row
    start = starting_position

    row_index == start
  end

  def starting_position
    color == BLACK_FOREGROUND ? 1 : 6
  end

  def one_step
    row_index = position.row
    col_index = position.col

    if color == BLACK_FOREGROUND
      [row_index + 1, col_index]
    else
      [row_index - 1, col_index]
    end
  end

  def two_steps
    row_index = position.row
    col_index = position.col
    moves = []

    2.times do
      moves <<
        if color == BLACK_FOREGROUN
          [row_index + 1, col_index]
        else
          [row_index - 1, col_index]
        end
    end

    moves
  end
end
