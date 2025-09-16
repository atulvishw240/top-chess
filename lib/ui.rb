require_relative '../modules/constants'
require_relative 'utility'
# Provides an Interface to Player to play game
class UserInterface
  include Constants
  include Utility

  def select_piece(player, selections)
    puts 'Enter the coordinates of a piece which you want to select.'
    selection = player.select(selections)
    to_position_object(selection)
  end

  def select_move(player, moves)
    puts 'Enter the coordinates where you would like to move your piece.'
    move = player.select(moves)
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

    return choice if choice.between?(1, 4)

    puts 'Please! Enter a valid input'
    promote_to
  end

  def display_markers_and_captures(board, moves)
    moves.each do |move|
      if board.contains_piece?(move)
        board.assign_color_to_square(move, Constants::CAPTURE)
      else
        board.update(Constants::MARKER, move)
      end
    end
  end

  def clean_markers_and_captures(board, moves)
    moves.each do |move|
      if board.contains_piece?(move)
        color = color(move)
        board.assign_color_to_square(move, color)
      else
        board.update(Constants::EMPTY, move)
      end
    end
  end

  def color(position)
    sum = position.row + position.col

    if sum.even?
      WHITE_BACKGROUND
    else
      CYAN_BACKGROUND
    end
  end

  # Convert d1 to Position.new(1, 4)
  def to_position_object(standard_form)
    coordinates = standard_form.chars
    row = to_row_index(coordinates[1].to_i)
    col = to_col_index(coordinates[0])

    Position.new(row, col)
  end
end
