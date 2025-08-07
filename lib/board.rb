# Handle Game Effect on Board
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, " Atul ") }
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