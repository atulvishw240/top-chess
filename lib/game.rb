require_relative "file_rank_interface"
# Contains Game Logic
class Game
  attr_reader :board, :current_player_id

  include FileRankInterface

  def initialize(board, player1, player2)
    @board = board
    @players = [player1, player2]
    @current_player_id = 0
  end

  def play
    setup_pieces_on_board
    loop do
      board.display
      p check?

      selections = pieces_available_for_selection

      p selections

      piece = select_piece(selections)

      moves = piece.get_possible_moves(board)
      moves.map!(&:to_standard)

      p moves

      move = select_move(moves)
      update_game_state(piece, move)

      switch_players!
    end
  end

  def pieces_available_for_selection
    pieces = pieces_set(current_player.color)
    selections = pieces.map do |piece|
      piece_available_for_selection(piece)
    end

    selections.compact # remove nil's
  end

  def piece_available_for_selection(piece)
    moves = piece.get_possible_moves(board)
    filtered_moves = filter_moves_that_does_not_remove_check(piece, moves)

    if filtered_moves.empty?
      nil
    else
      position = piece.position
      position.to_standard
    end
  end

  def filter_moves_that_does_not_remove_check(piece, moves)
    prev_position = piece.position
    filtered_moves = []
    moves.each do |move|
      # If this new_position contains piece then
      # Set the coordinate of this piece to -1, -1 (imaginary)
      if board.contains_piece?(move)
        opp_piece = board.get_piece(move)
        opp_piece.position = Position.new(-1, -1)
      end

      piece.position = move

      # If move resolves check then add it to filtered moves
      filtered_moves << move unless check?

      # Restore previous state for piece selected and captured piece (if there is any)
      piece.position = prev_position
      opp_piece.position = move if board.contains_piece?(move)
    end

    filtered_moves
  end

  def select_piece(selections)
    puts "Enter the coordinates of a piece which you want to select."
    selection = current_player.select(selections)
    position = to_position_object(selection)
    board.get_piece(position)
  end

  def select_move(moves)
    puts "Enter the coordinates where you would like to move your piece."
    move = current_player.select(moves)
    to_position_object(move)
  end

  def update_game_state(piece, move)
    board.delete_piece(move) if capture?(move)

    board.update(piece, move)
  end

  def check?
    pieces = pieces_set(opponent_player.color)
    moves = []
    pieces.each { |piece| moves += piece.get_possible_moves(board) }
    king = king(current_player.color)
    moves.include?(king.position)
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

# Convert d1 to Position.new(1, 4)
def to_position_object(standard_form)
  coordinates = standard_form.chars
  row = to_row_index(coordinates[1].to_i)
  col = to_col_index(coordinates[0])

  Position.new(row, col)
end
