require_relative "square"
# Handle Game Effect on Board
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { Square.new } }
  end

  def display
    board.each do |row|
      row.each do |square|
        print square
      end

      puts ""
    end
  end

  # --------------  PRIVATE METHODS  -------------------
  def assign_color_to_squares
    board.each_with_index do |row, row_index|
      row.each_with_index do |square, col_index|
        square.assign_color(row_index, col_index)
      end
    end
  end
end