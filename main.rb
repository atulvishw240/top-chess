require_relative "lib/board"
require_relative "lib/bishop"
require_relative "lib/position"

board = Board.new
bishop = Bishop.new("\e[38;5;45m")
pos = Position.new(3, 3)
board.update(bishop, pos)
board.display