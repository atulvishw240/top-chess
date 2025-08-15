require_relative "piece"
# Represents Pawn in our Game
class Pawn < Piece
  def unicode
    "\u{265F}"
  end

  def get_possible_moves(board)
    # Captures functionality is left for later
    move
  end

  def move
    row_index = position.row
    col_index = position.col
    steps = no_of_steps
    move_one_or_two_steps(steps, row_index, col_index)
  end

  def no_of_steps
    if start?
      2
    else
      1
    end
  end

  def move_one_or_two_steps(steps, row_index, col_index)
    moves = []
    counter = 1

    while counter <= steps
      row_index = forward(row_index)
      move = [row_index, col_index]
      moves << move

      counter += 1
    end

    moves
  end

  def forward(row_index)
    if black?
      row_index + 1
    else
      row_index - 1
    end
  end

  def black?
    color == BLACK_FOREGROUND
  end

  def start?
    row_index = position.row
    start = starting_position

    row_index == start
  end

  def starting_position
    black? ? 1 : 6
  end
end

pawn = Pawn.new("\e[38;5;160m")
pawn.position = Position.new(6, 3)
p pawn.move
