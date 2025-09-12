require_relative '../lib/position'
require_relative '../lib/board'
require_relative '../pieces/bishop'
require_relative '../pieces/pieces'
require_relative '../pieces/king'

describe Queen do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  before(:each) do
    @board = Board.new([], [])
  end

  describe '#get_possible_moves' do
    it 'returns all possible moves for a queen at [4, 4]' do
      @queen = Queen.new('Black', Position.new(4, 4))
      poss_moves = [get_pos(5, 5), get_pos(6, 6), get_pos(7, 7), get_pos(5, 3), get_pos(6, 2), get_pos(7, 1),
                    get_pos(3, 5), get_pos(2, 6), get_pos(1, 7), get_pos(3, 3), get_pos(2, 2), get_pos(1, 1),
                    get_pos(0, 0), get_pos(3, 4), get_pos(2, 4), get_pos(1, 4), get_pos(0, 4), get_pos(5, 4),
                    get_pos(6, 4), get_pos(7, 4), get_pos(4, 5), get_pos(4, 6), get_pos(4, 7), get_pos(4, 3),
                    get_pos(4, 2), get_pos(4, 1), get_pos(4, 0)]
      moves = @queen.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
