# Provides an Interface to Player to play game
class UserInterface
  def select_piece(player)
    puts 'Enter the coordinates of a piece which you want to select.'
    selection = player.select(selections)
    position = to_position_object(selection)
    board.get_piece(position)
  end

  def select_move(moves)
    puts 'Enter the coordinates where you would like to move your piece.'
    move = current_player.select(moves)
    to_position_object(move)
  end

  def promote_to
    puts 'Promote your pawn to:'
    puts '1) Queen'
    puts '2) Rook'
    puts '3) Bishop'
    puts '4) Knight'

    puts 'Enter your choice (integer): '
    choice = gets.chomp.to_i

    choice if choice.between?(1, 4)
  end

  def display_markers_and_captures(moves)
    moves.each do |move|
      if board.contains_piece?(move)
        board.assign_color_to_square(move, Constants::CAPTURE)
      else
        board.update(Constants::MARKER, move)
      end
    end
  end

  def clean_markers_and_captures(moves)
    moves.each do |move|
      if board.contains_piece?(move)
        color = color(move)
        board.assign_color_to_square(move, color)
      else
        board.update(Constants::EMPTY, move)
      end
    end
  end
end
