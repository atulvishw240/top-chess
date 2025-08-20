require_relative "../modules/constants"
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

  def assign_color(row_index, col_index)
    sum = add(row_index, col_index)

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

  # ------------------------- PRIVATE METHODS -------------------------------
  def add(row_index, col_index)
    row_index + col_index
  end
end
