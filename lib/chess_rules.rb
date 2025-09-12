require_relative '../modules/constants'
require_relative '../pieces/king'
require_relative '../pieces/queen'
require_relative '../pieces/rook'
require_relative '../pieces/knight'
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
      copy_board.delete_piece(move) if copy_board.contains_piece?(move)

      copy_piece = copy_board.get_piece(piece.position)
      copy_board.update(copy_piece, move)
      filtered_moves << move.to_standard unless check?(copy_board, piece.color)
    end

    filtered_moves
  end

  def check?(board, color)
    pieces = board.pieces_set(opponent_color(color))
    moves = []
    pieces.each { |piece| moves += piece.get_possible_moves(board) }
    king = board.king(color)
    moves.any? { |move| move == king.position }
  end

  def checkmate?(board, color)
    check?(board, color) && pieces_available_for_selection(board, color).empty?
  end

  def stalemate?(board, color)
    pieces_available_for_selection(board, color).empty?
  end

  def opponent_color(color)
    color == BLACK_FOREGROUND ? BROWN_FOREGROUND : BLACK_FOREGROUND
  end
end
