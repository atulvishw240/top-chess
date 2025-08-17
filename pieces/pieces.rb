require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "pawn"
require_relative "../lib/position"
# Reperesents Pieces which contains "Piece" objects
class Pieces
  attr_accessor :pieces

  def initialize(color)
    @pieces = create_pieces(color)
  end
end
