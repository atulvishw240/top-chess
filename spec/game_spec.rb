require_relative "../lib/game"
require_relative "../pieces/pieces"
require_relative "../pieces/queen"
require_relative "../pieces/king"
require_relative "../pieces/knight"
require_relative "../pieces/bishop"
require_relative "../modules/constants"

describe Game do
  describe "#check?" do
    it "returns true if current player is in check" do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(7, 3))
      pieces = [king, queen]
      board = Board.new(pieces)
      player1 = double("Atul", color: Constants::BLACK_FOREGROUND)
      player2 = double("Gaurav", color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }
      board.update(king, king.position)
      board.update(queen, queen.position)

      expect(game.check?).to eq(true)
    end

    it "returns false if current player isn't in check" do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      queen = Queen.new(Constants::BROWN_FOREGROUND, Position.new(7, 4))
      pieces = [king, queen]
      board = Board.new(pieces)
      player1 = double("Atul", color: Constants::BLACK_FOREGROUND)
      player2 = double("Gaurav", color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }
      board.update(king, king.position)
      board.update(queen, queen.position)

      expect(game.check?).to eq(false)
    end

    it "returns true when player king is in check by knight" do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      knight = Knight.new(Constants::BROWN_FOREGROUND, Position.new(2, 5))
      pieces = [king, knight]
      board = Board.new(pieces)
      player1 = double("Atul", color: Constants::BLACK_FOREGROUND)
      player2 = double("Gaurav", color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }
      board.update(king, king.position)
      board.update(knight, knight.position)

      expect(game.check?).to eq(true)
    end

    it "returns true when player king is in check by Bishop" do
      king = King.new(Constants::BLACK_FOREGROUND, Position.new(3, 3))
      bishop = Bishop.new(Constants::BROWN_FOREGROUND, Position.new(7, 7))
      pieces = [king, bishop]
      board = Board.new(pieces)
      player1 = double("Atul", color: Constants::BLACK_FOREGROUND)
      player2 = double("Gaurav", color: Constants::BROWN_FOREGROUND)
      game = Game.new(board, player1, player2)
      allow(game).to receive(:current_player) { player1 }
      allow(game).to receive(:opponent_player) { player2 }
      board.update(king, king.position)
      board.update(bishop, bishop.position)

      expect(game.check?).to eq(true)
    end
  end
end
