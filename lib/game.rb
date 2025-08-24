# Contains Game Logic
class Game
  attr_reader :board, :current_player_id

  def initialize(board, player1, player2)
    @board = board
    @players = [player1, player2]
    @current_player_id = 0
  end

  def play
    setup_pieces_on_board
    board.display
    loop do
      # Available selections for a player
      selections = board.possible_pieces_selection(current_player.color)
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
      board.delete_piece(new_position) if capture?(new_position)

      # Remove piece from old position and move to a new position
      board.update(piece, new_position)

      # Display updated state of board and switch players
      board.display
      switch_players!
    end
  end

  def check?
    # FOR all opponent pieces
    #   Calculate all possible moves
    #   If all possible moves contain the coordinates of current player's king THEN
    #   he's in check otherwise he isn't
  end

  def capture?(position)
    # If move contains a piece then its a capture. Because a piece can't possibly move to the position of another of its pieces
    board.contains_piece?(position)
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

  def setup_pieces_on_board
    board.pieces.each do |piece|
      board.update(piece, piece.position)
    end
  end
end
