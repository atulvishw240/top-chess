# Contains Game Logic
class Game
  attr_reader :board, :current_player_id

  def initialize(board, player1, player2)
    @board = board
    @players = [player1, player2]
    @current_player_id = 0
  end

  def play
    setup
    selections = black.possible_selections(board)
    p selections
    selection = current_player.select_piece(selections)
    p selection
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
    @current_player_id -= 1
  end

  def setup
    setup_pieces_on_board(black)
    setup_pieces_on_board(white)
    board.display
  end

  def setup_pieces_on_board(set)
    set.pieces.each do |piece|
      board.update(piece, piece.position)
    end
  end

  def black
    current_player.set
  end

  def white
    opponent_player.set
  end
end
