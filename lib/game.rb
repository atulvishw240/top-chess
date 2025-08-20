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
    loop do
      # Available selections for a player
      selections = current_player_set.possible_selections(board)
      p selections

      # Select a piece to make a move
      selection = current_player.select_piece(selections)
      position = Position.new(selection[0], selection[1])
      piece = board.get_piece(position)
      p piece

      # All possible moves for the selected piece
      moves = piece.get_possible_moves(board)
      p moves

      # Select a move out of all possible moves for a piece
      move = current_player.select_move(moves)
      new_position = Position.new(move[0], move[1])

      # Remove piece from old position and move to a new position
      board.remove(piece)
      piece.position = new_position
      board.update(piece)

      # Display updated state of board and switch players
      board.display
      switch_players!
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

  def setup
    setup_pieces_on_board(current_player_set)
    setup_pieces_on_board(opponent_player_set)
    board.display
  end

  def setup_pieces_on_board(set)
    set.pieces.each do |piece|
      board.update(piece)
    end
  end

  def current_player_set
    current_player.set
  end

  def opponent_player_set
    opponent_player.set
  end
end
