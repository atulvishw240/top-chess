require_relative '../lib/game'
require_relative '../pieces/pieces'
require_relative '../pieces/queen'
require_relative '../pieces/king'
require_relative '../pieces/knight'
require_relative '../pieces/bishop'
require_relative '../modules/constants'

describe Game do
  describe '#check?' do
    it 'returns true if current player is in check' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(7, 3))
      pieces = Pieces.new("\e[30m", "\e[41m")
      pieces.add_piece(king, king.position)
      pieces.add_piece(queen, queen.position)
      # pieces = [king, queen]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.check?).to eq(true)
    end

    it "returns false if current player isn't in check" do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(7, 4))
      pieces = [king, queen]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.check?).to eq(false)
    end

    it 'returns true when player king is in check by knight' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      knight = Knight.new(Constants::BROWN_FOREGROUND, Position.new(2, 5))
      pieces = [king, knight]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.check?).to eq(true)
    end

    it 'returns true when player king is in check by Bishop' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(7, 7))
      pieces = [king, bishop]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.check?).to eq(true)
    end
  end

  describe '#checkmate?' do
    it 'returns true if the current player got checkmated' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(1, 1))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(2, 0))
      pieces = [king, bishop, queen]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.checkmate?).to eq(true)
    end

    it 'returns false if the current player got checkmated' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(1, 1))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(2, 1))
      pieces = [king, bishop, queen]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.checkmate?).to eq(false)
    end

    it 'returns true if the current player got checkmated by rook roller' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      rook = Rook.new(Constants::BROWN_FOREGROUND, Position.new(0, 7))
      rook2 = Rook.new(Constants::BROWN_FOREGROUND, Position.new(1, 6))
      pieces = [king, rook, rook2]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.checkmate?).to eq(true)
    end

    it 'returns false if the current player did not get checkmated by rook roller' do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      rook = Rook.new(Constants::BROWN_FOREGROUND, Position.new(1, 7))
      rook2 = Rook.new(Constants::BROWN_FOREGROUND, Position.new(1, 6))
      pieces = [king, rook, rook2]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.checkmate?).to eq(false)
    end
  end

  describe '#stalemate' do
    it "returns true if king isn't in check and there are no possible moves" do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(0, 0))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(2, 1))
      pieces = [king, queen]
      board = Board.new(pieces)
      player1 = double('Atul', color: Constants::BLACK_FOREGROUND)
      player2 = double('Gaurav', color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }

      expect(game.stalemate?).to eq(true)
    end
  end
end
