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
      pieces = pieces_set(current_player.color)
      pieces.reject! { |piece| piece.get_possible_moves(board).empty? }
      selections = pieces.map do |piece|
        [piece.position.row, piece.position.col]
      end

      p selections

      puts ""
      p check?
      selection = current_player.select_piece(selections)
      position = Position.new(selection[0], selection[1])
      piece = board.get_piece(position)

      moves = piece.get_possible_moves(board)
      p moves

      move = current_player.select_move(moves)
      new_position = Position.new(move[0], move[1])
      board.delete_piece(new_position) if capture?(new_position)

      board.update(piece, new_position)

      board.display
      switch_players!
    end
  end

  def check?
    pieces = pieces_set(opponent_player.color)
    moves = []
    pieces.each { |piece| moves += piece.get_possible_moves(board) }

    moves.delete_if { |move| move.flatten.empty? }

    curr_king = king(current_player.color)
    position = curr_king.position
    king_coordinate = [position.row, position.col]
    moves.include?(king_coordinate)
  end

  def capture?(position)
    # If move contains a piece then its a capture.
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

  def king(color)
    board.pieces.each do |piece|
      return piece if same_color?(piece, color) && piece.is_a?(King)
    end
  end

  def same_color?(piece, color)
    piece.color == color
  end

  def pieces_set(color)
    pieces = []
    board.pieces.each do |piece|
      pieces << piece if same_color?(piece, color)
    end

    pieces
  end
end
