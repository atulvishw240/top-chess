require_relative 'pieces/pieces'
require_relative 'lib/game'
require_relative 'lib/player'

black = Pieces.new("\e[30m")
brown = Pieces.new("\e[38;5;160m")
pieces = black.pieces.concat(brown.pieces)
board = Board.new(pieces)
player1 = Player.new('Gaurav', "\e[38;5;160m")
player2 = Player.new('Atul', "\e[30m")
game = Game.new(board, player1, player2)

game.play
