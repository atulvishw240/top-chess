require_relative 'chess_rules'
require_relative 'ui'
require_relative '../modules/constants'
require_relative 'utility'
# Contains Game Logic
class Game
  attr_reader :board, :current_player_id, :rules, :ui

  include Utility
  include Constants

  def initialize(board, player1, player2)
    @board = board
    @players = [player1, player2]
    @current_player_id = 0
    @rules = ChessRules.new
    @ui = UserInterface.new
  end

  def play
    loop do
      board.display
      p rules.check?(board, current_player.color)

      selections = rules.pieces_available_for_selection(board, current_player.color)
      break if rules.checkmate?(board, current_player.color)

      p selections

      pos = ui.select_piece(current_player, selections)
      piece = board.get_piece(pos)

      moves = rules.all_legal_moves(board, piece)
      ui.display_markers_and_captures(board, moves)
      board.display
      ui.clean_markers_and_captures(board, moves)

      moves.map!(&:to_standard)

      p moves

      move = ui.select_move(current_player, moves)
      rules.update_game_state(board, piece, move)

      if rules.promotion?(board, current_player.color)
        choice = promote_to
        board.delete_piece(move)
        promoted_piece = piece_factory(choice, current_player.color, move)
        board.add_piece(promoted_piece)
        board.update(promoted_piece, move)
      end

      switch_players!
    end

    puts "The #{opponent_player.name} won the game!!"
  end

  def select_piece(selections)
    puts 'Enter the coordinates of a piece which you want to select.'
    selection = current_player.select(selections)
    position = to_position_object(selection)
    board.get_piece(position)
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

  def color(position)
    sum = position.row + position.col

    if sum.even?
      WHITE_BACKGROUND
    else
      CYAN_BACKGROUND
    end
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

  def current_player
    @players[current_player_id]
  end

  def opponent_player
    @players[opponent_player_id]
  end

  def opponent_player_id
    1 - current_player_id
  end

  def switch_players!
    @current_player_id = 1 - @current_player_id
  end

  # Convert d1 to Position.new(1, 4)
  def to_position_object(standard_form)
    coordinates = standard_form.chars
    row = to_row_index(coordinates[1].to_i)
    col = to_col_index(coordinates[0])

    Position.new(row, col)
  end
end
