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

  describe "#all_possible_moves" do
    it "returns all possible moves for rook at [4, 4]" do
      @rook.position = Position.new(4, 4)
      poss_moves = [[3, 4], [2, 4], [1, 4], [0, 4], [5, 4], [6, 4], [7, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2],
                    [4, 1], [4, 0]]
      moves = @rook.all_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
