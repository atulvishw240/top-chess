require_relative '../lib/position'
require_relative '../lib/board'
require_relative '../pieces/king'
require_relative '../pieces/bishop'
require_relative '../pieces/pieces'

describe King do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  before(:each) do
    @pieces = Pieces.new('Black', 'Brown')
    @board = Board.new(@pieces)
  end

  describe '#get_possible_moves' do
    it 'returns all possible moves for King at [3, 3]' do
      @king = King.new('Black', Position.new(3, 3))
      poss_moves = [get_pos(2, 2), get_pos(2, 3), get_pos(2, 4), get_pos(3, 2), get_pos(3, 4), get_pos(4, 2),
                    get_pos(4, 3), get_pos(4, 4)]
      moves = @king.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves for King at [3, 3] blocked by his own piece at [3, 2] & [4, 3]' do
      @king = King.new('Black', Position.new(3, 3))
      @bishop = Bishop.new('Black', Position.new(3, 2))
      @bishop2 = Bishop.new('Black', Position.new(4, 3))
      @board.update(@bishop, @bishop.position)
      @board.update(@bishop2, @bishop2.position)
      poss_moves = [get_pos(2, 2), get_pos(2, 3), get_pos(2, 4), get_pos(3, 4), get_pos(4, 2), get_pos(4, 4)]
      moves = @king.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
