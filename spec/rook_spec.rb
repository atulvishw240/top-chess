require_relative '../lib/position'
require_relative '../lib/board'
require_relative '../pieces/bishop'
require_relative '../pieces/rook'
require_relative '../pieces/pieces'

describe Rook do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  before(:each) do
    @pieces = Pieces.new('Black', 'Brown')
    @board = Board.new(@pieces)
  end

  describe '#get_possible_moves' do
    it 'returns all possible moves for rook at [4, 4]' do
      @rook = Rook.new('Black', Position.new(4, 4))
      poss_moves = [get_pos(3, 4), get_pos(2, 4), get_pos(1, 4), get_pos(0, 4), get_pos(5, 4), get_pos(6, 4),
                    get_pos(7, 4), get_pos(4, 5), get_pos(4, 6), get_pos(4, 7), get_pos(4, 3), get_pos(4, 2), get_pos(4, 1), get_pos(4, 0)]
      moves = @rook.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves for rook at [4, 4] blocked by own pieces at [5, 4] and [4, 5]' do
      @rook = Rook.new('Black', Position.new(4, 4))
      @bishop = Bishop.new('Black', Position.new(5, 4))
      @bishop2 = Bishop.new('Black', Position.new(4, 5))
      @board.update(@bishop, @bishop.position)
      @board.update(@bishop2, @bishop2.position)
      poss_moves = [get_pos(3, 4), get_pos(2, 4), get_pos(1, 4), get_pos(0, 4), get_pos(4, 3), get_pos(4, 2),
                    get_pos(4, 1), get_pos(4, 0)]
      moves = @rook.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves for rook at [4, 4] blocked by opponent piece at [6, 4]' do
      @rook = Rook.new('Black', Position.new(4, 4))
      @opp_bishop = Bishop.new('White', Position.new(6, 4))
      @board.update(@opp_bishop, @opp_bishop.position)
      poss_moves = [get_pos(3, 4), get_pos(2, 4), get_pos(1, 4), get_pos(0, 4), get_pos(5, 4), get_pos(6, 4),
                    get_pos(4, 5), get_pos(4, 6), get_pos(4, 7), get_pos(4, 3), get_pos(4, 2), get_pos(4, 1), get_pos(4, 0)]
      moves = @rook.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
