require_relative "../lib/position"
require_relative "../lib/bishop"
describe Bishop do
  describe "#all_possible_moves" do
    it "returns right diagonal moves for Bishop at [0, 0]" do
      bishop = Bishop.new("Black")
      bishop.position = Position.new(0, 0)
      poss_moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
      moves = bishop.all_possible_moves
      expect(moves).to eq(poss_moves)
    end
  end
end