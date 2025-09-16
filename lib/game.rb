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
end
