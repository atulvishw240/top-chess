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
      selections = current_player.set.possible_selections(board)
      p selections
      selection = current_player.select_piece(selections)
      position = Position.new(selection[0], selection[1])
      piece = board.get_piece(position)
      p piece
      moves = piece.get_possible_moves(board)
      p moves
      move = current_player.make_move(moves)
      new_position = Position.new(move[0], move[1])
      board.remove(piece)
      piece.move(new_position)
      board.update(piece)
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
    setup_pieces_on_board(black)
    setup_pieces_on_board(white)
    board.display
  end

  def setup_pieces_on_board(set)
    set.pieces.each do |piece|
      board.update(piece)
    end
  end

  def black
    current_player.set
  end

  def white
    opponent_player.set
  end
end
