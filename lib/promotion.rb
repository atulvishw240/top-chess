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

  def update_state(board, piece, move)
    choice = promote_to
    promoted_piece = piece_factory(choice, piece.color, move)

    # Update state to reflect promotion
    board.delete_piece(move)
    board.add_piece(promoted_piece)
    board.update(promoted_piece, move)
  end

  def promote_to
    puts 'Promote your pawn to:'
    puts '1) Queen'
    puts '2) Rook'
    puts '3) Bishop'
    puts '4) Knight'

    puts 'Enter your choice (integer): '
    choice = gets.chomp.to_i

    return choice if choice.between?(1, 4)

    puts 'Please! Enter a valid input'
    promote_to
  end

  def piece_factory(integer, color, position)
    case integer
    when 1
      Queen.new(color, position)
    when 2
      Rook.new(color, position)
    when 3
      Bishop.new(color, position)
    when 4
      Knight.new(color, position)
    end
  end
end
