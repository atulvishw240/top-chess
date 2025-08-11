require_relative "../lib/position"
require_relative "../lib/board"
require_relative "../lib/bishop"
require_relative "../lib/rook"

describe Rook do
  before(:each) do
    @board = Board.new
    @bishop = Bishop.new("Black")
    @bishop2 = Bishop.new("Black")
    @opp_bishop = Bishop.new("White")
    @rook = Rook.new("Black")
  end
end
