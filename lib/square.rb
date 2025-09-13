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

  def default_color_of_square(position)
    sum = position.row + position.col

    self.color =
      if sum.even?
        WHITE_BACKGROUND
      else
        CYAN_BACKGROUND
      end
  end

  def to_s
    "#{color}#{piece}#{RESET_TERMINAL}"
  end
end
