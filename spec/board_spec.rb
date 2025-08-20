require_relative "../lib/board"
require_relative "../lib/position"
require_relative "../pieces/bishop"
describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#get_piece(position)" do
    it "returns the piece at position" do
      position = Position.new(3, 3)
      @bishop = Bishop.new("Black", position)
      @board.update(@bishop)

      piece = @board.get_piece(position)
      expect(piece).to eq(@bishop)
    end
  end

  describe "#contains_piece?(pos)" do
    it "returns true if there's a piece at pos" do
      position = Position.new(3, 3)
      @bishop = Bishop.new("Black", position)
      @board.update(@bishop)

      expect(true).to eq(@board.contains_piece?(position))
    end

    it "returns false if there isn't a piece at pos" do
      position = Position.new(3, 3)
      expect(false).to eq(@board.contains_piece?(position))
    end
  end
end
