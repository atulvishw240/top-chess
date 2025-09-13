require_relative 'chess_rules'
require_relative '../modules/constants'
require_relative 'utility'
# Contains Game Logic
class Game
  attr_reader :board, :current_player_id, :rules

  include Utility
  include Constants

  def initialize(board, player1, player2)
    @board = board
    @players = [player1, player2]
    @current_player_id = 0
    @rules = ChessRules.new
  end

  def play
    loop do
      board.display
      p rules.check?(board, current_player.color)

      selections = rules.pieces_available_for_selection(board, current_player.color)
      break if rules.checkmate?(board, current_player.color)

      p selections

      piece = select_piece(selections)

      moves = rules.all_legal_moves(board, piece)
      display_markers_and_captures(moves)
      board.display
      clean_markers_and_captures(moves)

      moves.map!(&:to_standard)

      p moves

      move = select_move(moves)
      rules.update_game_state(board, piece, move)

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
