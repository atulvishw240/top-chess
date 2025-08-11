require_relative "piece"
# Represents King
class King < Piece
  # [top_left, front, top_right, left, right, bottom_left, down, bottom_right]
  MOVES_DIR = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze

  def unicode
    "\u{265A}"
  end

  def get_possible_moves(board)
    MOVES_DIR.map { |dir| calculate_move(board, dir) }.compact
  end

  # ------------------------- PRIVATE METHODDS ---------------------------------------------

  def calculate_move(board, dir)
    row_index = position.row + dir[0]
    col_index = position.col + dir[1]
    move = [row_index, col_index]

    position = Position.new(row_index, col_index)

    return unless position.valid?

    if board.contains_piece?(position)
      piece = board.get_piece(position)
      return if piece.color == color
    end

    move
  end
end
