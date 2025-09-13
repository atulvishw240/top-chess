require_relative 'piece'
require_relative '../lib/board'
require_relative '../lib/position'
# Represents Pawn in our Game
class Pawn < Piece
  def unicode
    "\u{265F}"
  end

  def get_possible_moves(board)
    steps = no_of_steps
    move_one_or_two_steps(board, position, steps) + capture(board, position)
  end

  def no_of_steps
    if start?
      2
    else
      1
    end
  end

  def capture(board, position)
    captures = []
    possible_captures = diagonals(position)
    possible_captures.each do |move|
      next unless move.valid? && board.contains_piece?(move)

      piece = board.get_piece(move)
      captures << move unless piece.color == color
    end

    captures
  end

  def move_one_or_two_steps(board, position, steps)
    moves = []
    move = position

    counter = 0
    while counter < steps
      move = forward(move)
      break if board.contains_piece?(move)

      moves << move
      counter += 1
    end

    moves
  end

  def forward(position)
    row_index = position.row
    col_index = position.col

    if black?
      get_pos(row_index + 1, col_index)
    else
      get_pos(row_index - 1, col_index)
    end
  end

  def diagonals(position)
    row_index = position.row
    col_index = position.col

    if black?
      [get_pos(row_index + 1, col_index + 1), get_pos(row_index + 1, col_index - 1)]
    else
      [get_pos(row_index - 1, col_index + 1), get_pos(row_index - 1, col_index - 1)]
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

  def last_position
    black? ? 7 : 0
  end

  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end
end
