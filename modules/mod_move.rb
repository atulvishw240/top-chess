# Calculate move for Knight and King which doesn't follow some pattern like Rook, Bishop
module Move
  def all_possible_moves(moves_dir, board)
    moves_dir.map { |dir| calculate_move(board, dir) }.compact
  end

  # ------------------------------ PRIVATE METHODS -----------------------------
  private

  def calculate_move(board, dir)
    row_index = position.row + dir[0]
    col_index = position.col + dir[1]

    position = Position.new(row_index, col_index)

    return unless position.valid?

    if board.contains_piece?(position)
      piece = board.get_piece(position)
      return if piece.color == color
    end

    position
  end
end
