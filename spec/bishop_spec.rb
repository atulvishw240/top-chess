require_relative '../lib/position'
require_relative '../lib/board'
require_relative '../pieces/bishop'
require_relative '../pieces/pieces'

describe Bishop do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  before(:each) do
    @pieces = Pieces.new('Black')
    @board = Board.new(@pieces)
  end

  describe '#get_possible_moves' do
    it 'returns upper right diagonal moves for Bishop at [0, 0]' do
      @bishop = Bishop.new('Black', Position.new(0, 0))
      poss_moves = [get_pos(1, 1), get_pos(2, 2), get_pos(3, 3), get_pos(4, 4), get_pos(5, 5), get_pos(6, 6),
                    get_pos(7, 7)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns upper left diagonal moves for @bishop at [0, 7]' do
      @bishop = Bishop.new('Black', Position.new(0, 7))
      poss_moves = [get_pos(1, 6), get_pos(2, 5), get_pos(3, 4), get_pos(4, 3), get_pos(5, 2), get_pos(6, 1),
                    get_pos(7, 0)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns lower left diagonal moves for @bishop at [7, 7]' do
      @bishop = Bishop.new('Black', Position.new(7, 7))
      poss_moves = [get_pos(6, 6), get_pos(5, 5), get_pos(4, 4), get_pos(3, 3), get_pos(2, 2), get_pos(1, 1),
                    get_pos(0, 0)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns lower right diagonal moves for @bishop at [7, 0]' do
      @bishop = Bishop.new('Black', Position.new(7, 0))
      poss_moves = [get_pos(6, 1), get_pos(5, 2), get_pos(4, 3), get_pos(3, 4), get_pos(2, 5), get_pos(1, 6),
                    get_pos(0, 7)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves for @bishop at [3, 3]' do
      @bishop = Bishop.new('Black', Position.new(3, 3))
      poss_moves = [get_pos(4, 4), get_pos(5, 5), get_pos(6, 6), get_pos(7, 7), get_pos(4, 2), get_pos(5, 1),
                    get_pos(6, 0), get_pos(2, 4), get_pos(1, 5), get_pos(0, 6), get_pos(2, 2), get_pos(1, 1), get_pos(0, 0)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves for @bishop at [0, 0] blocked by his own piece at [5, 5]' do
      @bishop = Bishop.new('Black', Position.new(0, 0))
      @board.update(@bishop, @bishop.position)
      @bishop2 = Bishop.new('Black', Position.new(5, 5))
      @board.update(@bishop2, @bishop2.position)
      poss_moves = [get_pos(1, 1), get_pos(2, 2), get_pos(3, 3), get_pos(4, 4)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end

    it "returns all possible moves for @bishop at [0, 0] blocked by opponent's piece at [5, 5]" do
      @bishop = Bishop.new('Black', Position.new(0, 0))
      @board.update(@bishop, @bishop.position)
      @bishop2 = Bishop.new('White', Position.new(5, 5))
      @board.update(@bishop2, @bishop2.position)
      poss_moves = [get_pos(1, 1), get_pos(2, 2), get_pos(3, 3), get_pos(4, 4), get_pos(5, 5)]
      moves = @bishop.get_possible_moves(@board)
      expect(moves).to eq(poss_moves)
    end
  end
end
