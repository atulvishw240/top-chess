require_relative '../modules/constants'
require_relative '../lib/promotion'
require_relative '../lib/position'
require_relative '../pieces/pawn'
describe Promotion do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  describe '#promotion?' do
    it 'returns true when a black pawn at (6, 0) moves to (7, 1)' do
      black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, Position.new(6, 0))
      move = Position.new(7, 1)
      promote = Promotion.new
      expect(promote.promotion?(black_pawn, move)).to eq(true)
    end

    it 'returns false when a black pawn at (5, 3) moves to (6, 3)' do
      black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, Position.new(5, 3))
      move = Position.new(6, 3)
      promote = Promotion.new
      expect(promote.promotion?(black_pawn, move)).to eq(false)
    end

    it 'returns true when a brown pawn at (1, 3) moves to (0, 4)' do
      brown_pawn = Pawn.new(Constants::BROWN_FOREGROUND, Position.new(1, 3))
      move = Position.new(0, 4)
      promote = Promotion.new
      expect(promote.promotion?(brown_pawn, move)).to eq(true)
    end

    it 'returns false when a brown pawn at (2, 3) moves to (1, 3)' do
      brown_pawn = Pawn.new(Constants::BROWN_FOREGROUND, Position.new(2, 3))
      move = Position.new(1, 3)
      promote = Promotion.new
      expect(promote.promotion?(brown_pawn, move)).to eq(false)
    end
  end
end
