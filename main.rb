require_relative "pieces/pieces"
require_relative "lib/game"
require_relative "lib/player"

board = Board.new
black = Pieces.new("\e[30m")
brown = Pieces.new("\e[38;5;160m")
player1 = Player.new("Atul", black)
player2 = Player.new("Gaurav", brown)
game = Game.new(board, player1, player2)

game.play
