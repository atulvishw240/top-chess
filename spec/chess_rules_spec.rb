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
end
