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
      break if rules.checkmate?(board, current_player.color)

      # Select a piece to move
      selections = rules.pieces_available_for_selection(board, current_player.color)
      p selections
      input = ui.select_piece(selections)
      break if input == 'resign'

      piece_pos = to_position_object(input)
      piece = board.get_piece(piece_pos)

      # Display possible actions for this piece (markers and captures)
      moves = rules.all_legal_moves(board, piece)
      ui.display_moves_and_captures(board, moves)

      # Convert move position objects into "a1" format
      standard_format = moves.map(&:to_standard)
      p standard_format

      # Ask player to make a move
      move = ui.select_move(standard_format)
      break if move == 'resign'

      move = to_position_object(move)

      # Update game state to relfect move
      rules.update_game_state(board, piece, move)
      if rules.promotion?(board, current_player.color)
        choice = ui.promote_to
        board.delete_piece(move)
        promoted_piece = piece_factory(choice, current_player.color, move)
        board.add_piece(promoted_piece)
        board.update(promoted_piece, move)
      end

      switch_players!
    end

    puts "The #{opponent_player.name} won the game!!"
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
