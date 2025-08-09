require_relative "ansi_codes"
require_relative "position"
# Represents Bishop in Our Game
class Bishop
  include ANSI

  attr_accessor :position
  attr_reader :color, :unicode

  def initialize(color)
    @color = color
    @unicode = "\u{265D}"
  end

  def all_possible_moves
    moves = []
  
    diagonals = [[1, 1], [1, -1], [-1, 1], [-1, -1]] # [upper right, upper left, lower right, lower left]
    diagonals.each do |diagonal|
      row_index = position.row
      col_index = position.col

      loop do
        row_index += diagonal[0]
        col_index += diagonal[1]

        break unless Position.new(row_index, col_index).valid?

        moves << [row_index, col_index]
      end
    end

    moves
  end

  def to_s
    "#{color}#{unicode} #{RESET_TERMINAL}"
  end
end
