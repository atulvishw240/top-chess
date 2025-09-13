require_relative '../lib/board'
require_relative '../pieces/pawn'
require_relative '../pieces/piece'
require_relative '../lib/position'
require_relative '../modules/constants'

describe Pawn do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  describe '#get_possible_moves' do
    it 'returns all possible moves when black pawn is at starting position' do
      pawn = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(1, 0))
      board = Board.new([pawn], [])
      poss_moves = [get_pos(2, 0), get_pos(3, 0)]
      moves = pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves when black pawn is at (3, 0)' do
      pawn = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(3, 0))
      board = Board.new([pawn], [])
      poss_moves = [get_pos(4, 0)]
      moves = pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves when black pawn is blocked by opponent piece' do
      black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(3, 0))
      brown_pawn = Pawn.new(Constants::BROWN_FOREGROUND, get_pos(4, 0))
      board = Board.new([black_pawn], [brown_pawn])
      poss_moves = []
      moves = black_pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves when black pawn is blocked by its own piece' do
      black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(3, 0))
      black_pawn2 = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(4, 0))
      board = Board.new([black_pawn], [black_pawn2])
      poss_moves = []
      moves = black_pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves when black pawn has a capture at one diagona' do
      black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(1, 0))
      brown_pawn = Pawn.new(Constants::BROWN_FOREGROUND, get_pos(2, 1))
      board = Board.new([black_pawn], [brown_pawn])
      poss_moves = [get_pos(2, 0), get_pos(3, 0), get_pos(2, 1)]
      moves = black_pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end

    it 'returns all possible moves when black pawn has a capture at one diagona' do
      black_pawn = Pawn.new(Constants::BLACK_FOREGROUND, get_pos(1, 1))
      brown_pawn = Pawn.new(Constants::BROWN_FOREGROUND, get_pos(2, 2))
      brown_pawn2 = Pawn.new(Constants::BROWN_FOREGROUND, get_pos(2, 0))
      board = Board.new([black_pawn], [brown_pawn, brown_pawn2])
      poss_moves = [get_pos(2, 1), get_pos(3, 1), get_pos(2, 2), get_pos(2, 0)]
      moves = black_pawn.get_possible_moves(board)
      expect(moves).to eq(poss_moves)
    end
  end
end
