require_relative '../lib/board'
require_relative '../pieces/pawn'
require_relative '../lib/position'
require_relative '../modules/constants'

describe Pawn do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  describe '#get_possible_moves' do
    it 'returns all possible moves when black pawn is at starting position' do
      pawn = Pawn.new(Constants::BLACK_FOREGROUND, Position.new(1, 0))
      board = Board.new([pawn], [])
      poss_moves = [get_pos(2, 0), get_pos(3, 0)]
      moves = pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves when black pawn is at (3, 0)' do
      pawn = Pawn.new(Constants::BLACK_FOREGROUND, Position.new(3, 0))
      board = Board.new([pawn], [])
      poss_moves = [get_pos(4, 0)]
      moves = pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end
  end
end
