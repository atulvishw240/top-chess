# Board is made up of squares
class Square
  RESET_TERMINAL = "\e[0m".freeze
  WHITE_BACKGROUND = "\e[47m".freeze
  CYAN_BACKGROUND = "\e[48;5;45m".freeze

  attr_accessor :color, :piece

  def initialize
    @piece = "  "
  end

  def to_s
    "#{color}#{piece}#{RESET_TERMINAL}"
  end

  def assign_color(row_index, col_index)
    sum = add(row_index, col_index)
  
    if sum.even?
      self.color = WHITE_BACKGROUND 
    else
      self.color = CYAN_BACKGROUND
    end
  end

  # ------------------------- PRIVATE METHODS -------------------------------
  def add(row_index, col_index)
    return row_index + col_index
  end
end