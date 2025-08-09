require_relative "position"
# Represents Bishop in Our Game
class Bishop
  attr_accessor :position, :color

  def initialize(color)
    @color = color
  end

  def all_possible_moves
    row_index = position.row
    col_index = position.col

    moves = []
    loop do
      row_index += 1
      col_index += 1

      break unless Position.new(row_index, col_index).valid?

      moves << [row_index, col_index]
    end

    row_index = position.row
    col_index = position.col

    loop do
      row_index += 1
      col_index -= 1

      break unless Position.new(row_index, col_index).valid?

      moves << [row_index, col_index]
    end

    moves
  end
end
