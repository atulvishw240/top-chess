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
end
