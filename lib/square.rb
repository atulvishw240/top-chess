require_relative "ansi_codes"
# Board is made up of squares
class Square
  include ANSI

  attr_accessor :color, :piece

  def initialize
    @piece = "  "
  end

  def contains_piece?
    piece.is_a?(Piece)
  end

  def assign_color(row_index, col_index)
    sum = add(row_index, col_index)
  
    if sum.even?
      self.color = WHITE_BACKGROUND 
    else
      self.color = CYAN_BACKGROUND
    end
  end

  def to_s
    "#{color}#{piece}#{RESET_TERMINAL}"
  end

  # ------------------------- PRIVATE METHODS -------------------------------
  def add(row_index, col_index)
    return row_index + col_index
  end
end