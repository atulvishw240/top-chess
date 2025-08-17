require_relative "../lib/position"
require_relative "../lib/board"
require_relative "../pieces/queen"

describe Queen do
  before(:each) do
    @board = Board.new
  end

  describe "#get_possible_moves" do
    it "returns all possible moves for Queen at [4, 4]" do
      @queen = Queen.new("Black", Position.new(4, 4))
      poss_moves = [[5, 5], [6, 6], [7, 7], [5, 3], [6, 2], [7, 1], [3, 5], [2, 6], [1, 7], [3, 3], [2, 2], [1, 1],
                    [0, 0], [3, 4], [2, 4], [1, 4], [0, 4], [5, 4], [6, 4], [7, 4], [4, 5], [4, 6], [4, 7], [4, 3], [4, 2], [4, 1], [4, 0]]
      moves = @queen.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
