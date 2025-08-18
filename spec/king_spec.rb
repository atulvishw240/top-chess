require_relative "../lib/position"
require_relative "../lib/board"
require_relative "../pieces/king"
require_relative "../pieces/bishop"

describe King do
  before(:each) do
    @board = Board.new
  end

  describe "#get_possible_moves" do
    it "returns all possible moves for King at [3, 3]" do
      @king = King.new("Black", Position.new(3, 3))
      poss_moves = [[2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4]]
      moves = @king.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it "returns all possible moves for King at [3, 3] blocked by his own piece at [3, 2] & [4, 3]" do
      @king = King.new("Black", Position.new(3, 3))
      @bishop = Bishop.new("Black", Position.new(3, 2))
      @bishop2 = Bishop.new("Black", Position.new(4, 3))
      @board.update(@bishop)
      @board.update(@bishop2)
      poss_moves = [[2, 2], [2, 3], [2, 4], [3, 4], [4, 2], [4, 4]]
      moves = @king.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
