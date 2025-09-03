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
      p check?

      # Get all pieces of current player
      pieces = pieces_set(current_player.color)
      # FOR each piece
      selections = []
      pieces.each do |piece|
        #   Calculate all possible moves
        moves = piece.get_possible_moves(board)
        #   Select only those moves which gets us out of check
        filtered_moves = filter_moves_that_does_not_remove_check(piece, moves)
        selections << [piece.position.row, piece.position.col] unless filtered_moves.empty?
      end

      #   If you get a non-empty set in previous step then add this piece to "set of possible selections"
      # ENDFOR
      # return "set of possible selections"

      # pieces = pieces_set(current_player.color)
      # pieces.reject! { |piece| piece.get_possible_moves(board).empty? }
      # selections = pieces.map do |piece|
      #   [piece.position.row, piece.position.col]
      # end

      p selections

      puts ""
      selection = current_player.select_piece(selections)
      position = Position.new(selection[0], selection[1])
      piece = board.get_piece(position)

      move = make_move(piece)
      update_state_on_move(piece, move)

      board.display
      switch_players!
    end
  end

  #   Select only those moves which gets us out of check
  def filter_moves_that_does_not_remove_check(piece, moves)
    prev_position = piece.position
    filtered_moves = []
    moves.each do |move|
      new_position = Position.new(move[0], move[1])
      # If this new_position contains piece then
      # Set the coordinate of this piece to -1, -1 (imaginary)
      if board.contains_piece?(new_position)
        opp_piece = board.get_piece(new_position)
        opp_piece.position = Position.new(-1, -1)
      end

      piece.position = new_position
      filtered_moves << move unless check?
      piece.position = prev_position
      opp_piece.position = new_position if board.contains_piece?(new_position)
    end

    filtered_moves
  end

  def make_move(piece)
    moves = piece.get_possible_moves(board)
    p moves

    move = current_player.select_move(moves)
    Position.new(move[0], move[1])
  end

  def update_state_on_move(piece, move)
    board.delete_piece(move) if capture?(move)

    board.update(piece, move)
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
