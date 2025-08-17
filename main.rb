require_relative "pieces/pieces"
require_relative "lib/game"

board = Board.new
black = Pieces.new("\e[30m")
brown = Pieces.new("\e[38;5;160m")
game = Game.new(board, black, brown)

game.setup
