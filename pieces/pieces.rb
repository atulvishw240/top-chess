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
    @pieces = create_set_of_pieces(color)
  end

  def create_set_of_pieces(color)
    pieces_set = []

    pieces_set += create_pawns(color)
    pieces_set += create_pieces(color)

    pieces_set
  end

  def create_pawns(color)
    pawns = []
    pawn_row = color == BLACK_FOREGROUND ? 1 : 6
    (0..7).each do |col|
      pawns << Pawn.new(color, Position.new(pawn_row, col))
    end

    pawns
  end

  def create_pieces(color) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    pieces = []

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
