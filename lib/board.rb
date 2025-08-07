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
end