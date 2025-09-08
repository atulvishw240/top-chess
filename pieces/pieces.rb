require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative '../lib/position'
require_relative '../modules/constants'
# Reperesents Pieces which contains "Piece" objects
class Pieces
  include Constants

  attr_accessor :pieces

  def initialize(color)
    @pieces = create_pieces(color)
  end

  def create_pieces(color) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    # Create Pawns
    pieces = []
    pawn_row = color == BLACK_FOREGROUND ? 1 : 6
    (0..7).each do |col|
      pieces << Pawn.new(color, Position.new(pawn_row, col))
    end

    # Create Pieces
    piece_row = color == BLACK_FOREGROUND ? 0 : 7
    pieces << Rook.new(color, Position.new(piece_row, 0))
    pieces << Rook.new(color, Position.new(piece_row, 7))
    pieces << Knight.new(color, Position.new(piece_row, 1))
    pieces << Knight.new(color, Position.new(piece_row, 6))
    pieces << Bishop.new(color, Position.new(piece_row, 2))
    pieces << Bishop.new(color, Position.new(piece_row, 5))
    pieces << Queen.new(color, Position.new(piece_row, 3))
    pieces << King.new(color, Position.new(piece_row, 4))

    pieces
  end
end
