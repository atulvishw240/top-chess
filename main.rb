require_relative "lib/board"
require_relative "lib/ansi_codes"
require_relative "pieces/pieces"

black = Pieces.new("\e[30m")
brown = Pieces.new("\e[38;5;160m")
board = Board.new(black.pieces, brown.pieces)
board.display
