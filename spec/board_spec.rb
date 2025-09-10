require_relative '../lib/board'
require_relative '../lib/position'
require_relative '../pieces/bishop'
require_relative '../pieces/pieces'

BLACK_FOREGROUND = "\e[30m".freeze
BROWN_FOREGROUND = "\e[38;5;160m".freeze
describe Board do
  before(:each) do
    @pieces = Pieces.new(BLACK_FOREGROUND, BROWN_FOREGROUND)
    @board = Board.new(@pieces.all_pieces)
  end

  describe '#get_piece(position)' do
    it 'returns the piece at position' do
      position = Position.new(3, 3)
      @bishop = Bishop.new('Black', position)
      @board.update(@bishop, position)

      piece = @board.get_piece(position)
      expect(piece).to eq(@bishop)
    end
  end

  describe '#contains_piece?(pos)' do
    it "returns true if there's a piece at pos" do
      position = Position.new(3, 3)
      @bishop = Bishop.new('Black', position)
      @board.update(@bishop, position)

      expect(true).to eq(@board.contains_piece?(position))
    end

    it "returns false if there isn't a piece at pos" do
      position = Position.new(3, 3)
      expect(false).to eq(@board.contains_piece?(position))
    end
  end

  describe '#update' do
    it 'updates the board state' do
      piece = Bishop.new('Black', Position.new(3, 3))
      new_position = Position.new(5, 5)
      @board.update(piece, new_position)

      expect(piece).to eq(@board.get_piece(new_position))
    end
  end

  describe '#delete' do
    it 'deletes piece from Board' do
      position = Position.new(0, 2)
      piece = Bishop.new(BLACK_FOREGROUND, position)
      @board.update(piece, piece.position)
      @board.delete_piece(position)
      expect(@board.contains_piece?(position)).to eq(false)
    end
  end
end
