require_relative 'piece'
require_relative '../lib/board'
# Represents Pawn in our Game
class Pawn < Piece
  def unicode
    "\u{265F}"
  end

  def get_possible_moves(board)
    # Captures functionality is left for later
    steps = no_of_steps
    move_one_or_two_steps(board, position, steps) + capture(board, position)
  end

  # def move
  #   row_index = position.row
  #   col_index = position.col
  #   steps = no_of_steps
  #   move_one_or_two_steps(steps, row_index, col_index)
  # end

  def no_of_steps
    if start?
      2
    else
      1
    end
  end

  def capture(board, position)
    captures = []

    row_index = position.row
    col_index = position.col
    diagonals = diagonals(row_index, col_index)
    diagonals.each do |coordinate|
      move = Position.new(coordinate[0], coordinate[1])
      next unless move.valid?

      if board.contains_piece?(move)
        piece = board.get_piece(move)
        captures << move unless piece.color == color
      end
    end

    captures
  end

  def move_one_or_two_steps(board, position, steps)
    moves = []
    counter = 1
    row_index = position.row
    col_index = position.col

    while counter <= steps
      row_index = forward(row_index)
      move = Position.new(row_index, col_index)
      break if board.contains_piece?(move)

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

  def diagonals(row_index, col_index)
    if black?
      [[row_index + 1, col_index + 1], [row_index + 1, col_index - 1]]
    else
      [[row_index - 1, col_index + 1], [row_index - 1, col_index - 1]]
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

black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, Position.new(1, 0))
brown_pawn = Pawn.new(Constants::BROWN_FOREGROUND, Position.new(2, 1))
board = Board.new([black_pawn], [brown_pawn])
# poss_moves = [get_pos(2, 0), get_pos(3, 0), get_pos(2, 1)]
p black_pawn.get_possible_moves(board)
