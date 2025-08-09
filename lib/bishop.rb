# Represents Bishop in Our Game
class Bishop
  attr_accessor :position, :color

  def initialize(color)
    @color = color
  end

  def all_possible_moves
    row_index = position[0]
    col_index = position[1]
    moves = []
    loop do
      row_index = row_index + 1
      col_index = col_index + 1

      break unless valid_position?(row_index, col_index)

      moves << [row_index, col_index]
    end

    moves
  end

  def valid_position?(row_index, col_index)
    row_index.between?(0, 7) && col_index.between?(0, 7)
  end
end

bishop = Bishop.new("Black")
bishop.position = [2, 4]

p bishop.all_possible_moves
