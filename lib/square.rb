require_relative '../modules/constants'
# Board is made up of squares
class Square
  include Constants

  attr_accessor :color, :piece

  def initialize
    @piece = EMPTY
  end

  def contains_piece?
    piece.is_a?(Piece)
  end

  def to_s
    "#{color}#{piece}#{RESET_TERMINAL}"
  end
end
