require_relative '../lib/castle'
require_relative '../pieces/king'
require_relative '../pieces/rook'
require_relative '../pieces/bishop'
require_relative '../lib/board'

describe Castle do
  def get_pos(row_index, col_index)
    Position.new(row_index, col_index)
  end

  describe '#king_side_castling for black' do
    it 'returns true if black king can castle' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      board = Board.new([king, rook], [])
      castling = Castle.new
      expect(castling.king_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns false if black king cant castle' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      king.has_moved = true
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      board = Board.new([king, rook], [])
      castling = Castle.new
      expect(castling.king_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end

    it 'returns false if black king cant castle' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      rook.has_moved = true
      board = Board.new([king, rook], [])
      castling = Castle.new
      expect(castling.king_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end

    it 'returns false if black king cant castle' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      rook2 = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 6))
      board = Board.new([king, rook, rook2], [])
      castling = Castle.new
      expect(castling.king_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end

    it 'returns false if the square king pass through is attacked by an enemy piece' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(5, 0))
      board = Board.new([king, rook], [bishop])
      castling = Castle.new
      expect(castling.king_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end

    it 'returns false if the square king lands on is attacked by an enemy piece' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(6, 0))
      board = Board.new([king, rook], [bishop])
      castling = Castle.new
      expect(castling.king_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end
  end

  describe '#queen_side_castling for black' do
    it 'returns true when black king can castle queen side' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      board = Board.new([king, rook], [])
      castling = Castle.new
      expect(castling.queen_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when black king can castle queen side' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      king.has_moved = true
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      board = Board.new([king, rook], [])
      castling = Castle.new
      expect(castling.queen_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end

    it 'returns true when black king can castle queen side' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      rook2 = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 1))
      board = Board.new([king, rook, rook2], [])
      castling = Castle.new
      expect(castling.queen_side_castling(board, Constants::BLACK_FOREGROUND)).to eq(false)
    end
  end

  describe '#castling_moves' do
    it 'return castling move for kingside castling of black' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BLACK_FOREGROUND, Position.new(0, 7))
      board = Board.new([king, rook], [])
      castling = Castle.new
      castling_moves = [Position.new(0, 6)]
      expect(castling.castling_moves(board, Constants::BLACK_FOREGROUND)).to eq(castling_moves)
    end
  end
end
