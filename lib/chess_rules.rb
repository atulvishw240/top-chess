require_relative '../modules/constants'
require_relative '../pieces/king'
require_relative '../pieces/queen'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
require_relative '../pieces/pawn'
# Contains game logic for our chess
class ChessRules
  include Constants

  def pieces_available_for_selection(board, color)
    selections = []
    pieces = board.pieces_set(color)
    pieces.each do |piece|
      moves = all_legal_moves(board, piece)
      selections << piece.position.to_standard unless moves.empty?
    end

    selections
  end

  def all_legal_moves(board, piece)
    moves = piece.get_possible_moves(board)

    filtered_moves = []
    moves.each do |move|
      copy_board = Marshal.load(Marshal.dump(board))
      copy_piece = copy_board.get_piece(piece.position)
      update_game_state(copy_board, copy_piece, move)
      filtered_moves << move unless check?(copy_board, piece.color)
    end

    filtered_moves
  end

  def update_game_state(board, piece, position)
    board.delete_piece(position) if capture?(board, position)

    prev_position = piece.position
    board.update(Constants::EMPTY, prev_position)
    piece.position = position
    board.update(piece, position)
  end

  def capture?(board, position)
    # If move contains a piece then its a capture.
    board.contains_piece?(position)
  end

  def check?(board, color)
    moves = all_possible_moves_for_opponent(board, color)
    king = board.king(color)
    moves.any? { |move| move == king.position }
  end

  def all_possible_moves_for_opponent(board, color)
    pieces = board.pieces_set(opponent_color(color))
    moves = []
    pieces.each { |piece| moves += piece.get_possible_moves(board) }

    moves
  end

  def checkmate?(board, color)
    in_check = check?(board, color)
    no_valid_moves = pieces_available_for_selection(board, color).empty?

    in_check && no_valid_moves
  end

  def stalemate?(board, color)
    pieces_available_for_selection(board, color).empty?
  end

  def promotion?(board, color)
    pawns = board.pawns(color)
    pawns.any? do |pawn|
      (pawn.color == BLACK_FOREGROUND && pawn.position.row == 7) ||
        (pawn.color == BROWN_FOREGROUND && pawn.position.row.zero?)
    end
  end

  def opponent_color(color)
    color == BLACK_FOREGROUND ? BROWN_FOREGROUND : BLACK_FOREGROUND
  end
end
