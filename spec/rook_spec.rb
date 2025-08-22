require_relative "../lib/position"
require_relative "../lib/board"
require_relative "../pieces/bishop"
require_relative "../pieces/rook"

describe Rook do
  before(:each) do
    @board = Board.new
  end

  describe "#get_possible_moves" do
    it "returns all possible moves for rook at [4, 4]" do
      @rook = Rook.new("Black", Position.new(4, 4))
      poss_moves = [[3, 4], [2, 4], [1, 4], [0, 4], [5, 4], [6, 4], [7, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2],
                    [4, 1], [4, 0]]
      moves = @rook.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it "returns all possible moves for rook at [4, 4] blocked by own pieces at [5, 4] and [4, 5]" do
      @rook = Rook.new("Black", Position.new(4, 4))
      @bishop = Bishop.new("Black", Position.new(5, 4))
      @bishop2 = Bishop.new("Black", Position.new(4, 5))
      @board.update(@bishop, @bishop.position)
      @board.update(@bishop2, @bishop2.position)
      poss_moves = [[3, 4], [2, 4], [1, 4], [0, 4], [4, 3], [4, 2], [4, 1], [4, 0]]
      moves = @rook.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it "returns all possible moves for rook at [4, 4] blocked by opponent piece at [6, 4]" do
      @rook = Rook.new("Black", Position.new(4, 4))
      @opp_bishop = Bishop.new("White", Position.new(6, 4))
      @board.update(@opp_bishop, @opp_bishop.position)
      poss_moves = [[3, 4], [2, 4], [1, 4], [0, 4], [5, 4], [6, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1],
                    [4, 0]]
      moves = @rook.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
