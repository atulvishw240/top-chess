require_relative "../lib/position"
require_relative "../lib/bishop"
describe Bishop do
  describe "#all_possible_moves" do
    it "returns upper right diagonal moves for Bishop at [0, 0]" do
      bishop = Bishop.new("Black")
      bishop.position = Position.new(0, 0)
      poss_moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
      moves = bishop.all_possible_moves
      expect(moves).to eq(poss_moves)
    end

    it "returns upper left diagonal moves for Bishop at [0, 7]" do
      bishop = Bishop.new("Black")
      bishop.position = Position.new(0, 7)
      poss_moves = [[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1], [7, 0]]
      moves = bishop.all_possible_moves
      expect(moves).to eq(poss_moves)
    end

    it "returns lower left diagonal moves for Bishop at [7, 7]" do
      bishop = Bishop.new("Black")
      bishop.position = Position.new(7, 7)
      poss_moves = [[6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0]]
      moves = bishop.all_possible_moves
      expect(moves).to eq(poss_moves)
    end

    it "returns lower right diagonal moves for Bishop at [7, 0]" do
      bishop = Bishop.new("Black")
      bishop.position = Position.new(7, 0)
      poss_moves = [[6, 1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]]
      moves = bishop.all_possible_moves
      expect(moves).to eq(poss_moves)
    end
  end
end