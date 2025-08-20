require_relative "../lib/position"
require_relative "../modules/constants"
# Implements our Piece
class Piece
  include Constants

  attr_accessor :position
  attr_reader :color

  def initialize(color, position)
    @color = color
    @position = position
    @unicode = unicode
  end

  def unicode
    raise NotImplementedError, "All Pieces must implement unicode"
  end

  def get_possible_moves(board)
    raise NotImplementedError, "All Pieces must implement get_possible_moves"
  end

  def to_s
    "#{color}#{unicode} #{RESET_TERMINAL}"
  end
end
