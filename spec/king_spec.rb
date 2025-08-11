require_relative "../lib/position"
require_relative "../lib/board"
require_relative "../pieces/king"
require_relative "../pieces/bishop"

describe King do
  before(:each) do
    @board = Board.new
    @king = King.new("Black")
    @bishop = Bishop.new("Black")
    @bishop2 = Bishop.new("Black")
  end

  describe "#all_possible_moves" do
    it "returns all possible moves for King at [3, 3]" do
      @king.position = Position.new(3, 3)
      poss_moves = [[2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4]]
      moves = @king.all_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it "returns all possible moves for King at [3, 3] blocked by his own piece at [3, 2] & [4, 3]" do
      @king.position = Position.new(3, 3)
      @board.update(@bishop, Position.new(3, 2))
      @board.update(@bishop2, Position.new(4, 3))
      poss_moves = [[2, 2], [2, 3], [2, 4], [3, 4], [4, 2], [4, 4]]
      moves = @king.all_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
