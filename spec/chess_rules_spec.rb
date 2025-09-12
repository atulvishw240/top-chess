require_relative '../lib/chess_rules'
require_relative '../pieces/king'
require_relative '../pieces/queen'
require_relative '../pieces/bishop'
require_relative '../pieces/knight'
require_relative '../pieces/rook'
require_relative '../lib/board'
require_relative 'chess_rules_spec'
require_relative '../modules/constants'

describe ChessRules do
  describe '#check' do
    it 'returns true when the black king is in check by brown queen' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(7, 3))
      board = Board.new([king], [queen])
      rules = ChessRules.new
      expect(rules.check?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when the black king is in check by brown bishop' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(7, 7))
      board = Board.new([king], [bishop])
      rules = ChessRules.new
      expect(rules.check?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when the black king is in check by brown knight' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      knight = Knight.new(Constants::BROWN_FOREGROUND, Position.new(5, 4))
      board = Board.new([king], [knight])
      rules = ChessRules.new
      expect(rules.check?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when the black king is in check by brown rook' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      rook = Rook.new(Constants::BROWN_FOREGROUND, Position.new(7, 3))
      board = Board.new([king], [rook])
      rules = ChessRules.new
      expect(rules.check?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end
  end

  describe '#all_legal_moves' do
    it 'returns all legal moves for black king' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 4))
      rook = Rook.new(Constants::BROWN_FOREGROUND, Position.new(7, 4))
      board = Board.new([king], [rook])
      rules = ChessRules.new
      expect(rules.all_legal_moves(board, king)).to eq(%w[d8 f8 d7 f7])
    end
  end

  describe '#possible_pieces_available_for_selection' do
    it 'returns the pieces that can resolve check' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(1, 5))
      knight = Knight.new(Constants::BLACK_FOREGROUND, Position.new(0, 6))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(6, 5))
      board = Board.new([king, knight], [queen])
      rules = ChessRules.new
      expect(rules.pieces_available_for_selection(board, Constants::BLACK_FOREGROUND)).to eq(%w[f7 g8])
    end
  end

  describe '#checkmate' do
    it 'returns true when black king gets checkmated by two brown rooks' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      rook = Rook.new(Constants::BROWN_FOREGROUND, Position.new(0, 5))
      rook2 = Rook.new(Constants::BROWN_FOREGROUND, Position.new(1, 5))
      board = Board.new([king], [rook, rook2])
      rules = ChessRules.new
      expect(rules.checkmate?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when black king gets checkmated by one queen and bishop' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(1, 1))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(6, 6))
      board = Board.new([king], [queen, bishop])
      rules = ChessRules.new
      expect(rules.checkmate?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when black king gets checkmated by two knight and king' do
      black_king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      knight = Knight.new(Constants::BROWN_FOREGROUND, Position.new(2, 1))
      knight2 = Knight.new(Constants::BROWN_FOREGROUND, Position.new(2, 2))
      brown_king = King.new(Constants::BROWN_FOREGROUND, Position.new(2, 0))
      board = Board.new([black_king], [knight, knight2, brown_king])
      rules = ChessRules.new
      expect(rules.checkmate?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end

    it 'returns true when black king gets checkmated by two brown bishops and brown king' do
      black_king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(7, 7))
      bishop2 = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(6, 7))
      brown_king = King.new(Constants::BROWN_FOREGROUND, Position.new(2, 0))
      board = Board.new([black_king], [bishop, bishop2, brown_king])
      rules = ChessRules.new
      expect(rules.checkmate?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end
  end

  describe '#stalemate' do
    it 'returns true when black has no possible moves and he is not in check' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(2, 1))
      board = Board.new([king], [queen])
      rules = ChessRules.new
      expect(rules.stalemate?(board, Constants::BLACK_FOREGROUND)).to eq(true)
    end
  end
end
