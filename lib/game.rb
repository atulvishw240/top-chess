require_relative 'file_rank_interface'
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
      break if checkmate?

      p selections

      piece = select_piece(selections)

      moves = piece.get_possible_moves(board)
      moves.map!(&:to_standard)

      p moves

      move = select_move(moves)
      update_game_state(piece, move)

      switch_players!
    end

    puts "The #{opponent_player.name} won the game!!"
  end

  def pieces_available_for_selection
    selections = []
    pieces = pieces_set(current_player)
    pieces.each do |piece|
      moves = all_possible_moves(piece)
      selections << piece.position.to_standard unless moves.empty?
    end

    selections
  end

  def all_possible_moves(piece)
    moves = piece.get_possible_moves(board)
    moves = filter_moves_that_does_not_remove_check(piece, moves) if check?

    moves
  end

  def filter_moves_that_does_not_remove_check(piece, moves)
    prev_position = piece.position
    filtered_moves = []
    moves.each do |move|
      next unless board.contains_piece?(move)

      # Create a deep copy of Game object
      copy_game = Marshal.load(Marshal.dump(self))
      copy_board = copy_game.board
      copy_board.delete_piece(move) if copy_board.contains_piece?(move)

      copy_piece = copy_board.get_piece(prev_position)
      copy_piece.position = move
      filtered_moves << move unless copy_game.check?
    end

    filtered_moves
  end

  def select_piece(selections)
    puts 'Enter the coordinates of a piece which you want to select.'
    selection = current_player.select(selections)
    position = to_position_object(selection)
    board.get_piece(position)
  end

  def select_move(moves)
    puts 'Enter the coordinates where you would like to move your piece.'
    move = current_player.select(moves)
    to_position_object(move)
  end

  def update_game_state(piece, move)
    board.delete_piece(move) if capture?(move)

    board.update(piece, move)
  end

  def check?
    pieces = pieces_set(opponent_player)
    moves = []
    pieces.each { |piece| moves += piece.get_possible_moves(board) }
    king = king(current_player)
    moves.any? { |move| move == king.position }
  end

  def checkmate?
    check? && pieces_available_for_selection.empty?
  end

  def stalemate?
    pieces_available_for_selection.empty?
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

  def pieces_set(player)
    pieces = []
    board.pieces.each do |piece|
      pieces << piece if piece.color == player.color
    end

    pieces
  end

  def king(player)
    board.pieces.each do |piece|
      return piece if piece.color == player.color && piece.is_a?(King)
    end
  end

  def setup_pieces_on_board
    board.pieces.each do |piece|
      board.update(piece, piece.position)
    end
  end

  # Convert d1 to Position.new(1, 4)
  def to_position_object(standard_form)
    coordinates = standard_form.chars
    row = to_row_index(coordinates[1].to_i)
    col = to_col_index(coordinates[0])

    Position.new(row, col)
  end
end
