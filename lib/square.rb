# Board is made up of squares
class Square
  WHITE_BACKGROUND = "\e[47m".freeze
  CYAN_BACKGROUND = "\e[48;5;45m".freeze
  RESET_TERMINAL = "\e[0m".freeze

  attr_accessor :color

  def to_s
    "Square"
  end

  def assign_color(row_index, col_index)
    sum = add(row_index, col_index)
    self.color = WHITE_BACKGROUND if sum.even?

    self.color = CYAN_BACKGROUND
  end

  # ------------------------- PRIVATE METHODS -------------------------------
  def add(row_index, col_index)
    return row_index + col_index
  end
end