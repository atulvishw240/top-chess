# Calculate Moves in a dir (Direction)
# direction is given as coordinates
module CalcMoves
  def calculate_moves_in_one_dir(board, dir) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    moves = []

    row_index = dir[0] + position.row
    col_index = dir[1] + position.col
    position = Position.new(row_index, col_index)

    while position.valid?
      move = [row_index, col_index]

      if board.contains_piece?(position)
        piece = board.get_piece(position)
        moves << move unless piece.color == color
        break
      end

      moves << move

      row_index += dir[0]
      col_index += dir[1]
      position = Position.new(row_index, col_index)
    end

    moves
  end
end
