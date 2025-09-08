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

  private attr_reader :dark, :light
  attr_accessor :all_pieces

  def initialize(dark, light)
    @dark = dark
    @light = light
    # @all_pieces = dark_set + light_set
    @all_pieces = create_set_of_pieces(dark) + create_set_of_pieces(light)
  end

  def create_set_of_pieces(color)
    pieces_set = []

    pieces_set += create_pawns(color)
    pieces_set += create_pieces(color)

    pieces_set
  end

  def create_pawns(color)
    pawns = []
    pawn_row = color == dark ? 1 : 6
    (0..7).each do |col|
      pawns << Pawn.new(color, Position.new(pawn_row, col))
    end

    pawns
  end

  def create_pieces(color) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    pieces = []

    piece_row = color == dark ? 0 : 7
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

  def set(color)
    pieces = []
    all_pieces.each do |piece|
      pieces << piece if piece.color == color
    end

    pieces
  end

  def king(color)
    all_pieces.each do |piece|
      return piece if piece.color == color && piece.is_a?(King)
    end
  end

  def delete_piece(position)
    all_pieces.each do |piece|
      next unless position == piece.position

      all_pieces.delete(piece)
    end
  end

  def add_piece(piece, position)
    piece.position = position
    all_pieces << piece
  end
end
