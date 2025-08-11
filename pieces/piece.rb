require_relative "../lib/position"
require_relative "../lib/ansi_codes"
# Implements our Piece
class Piece
  include ANSI

  attr_accessor :position
  attr_reader :color, :unicode

  def initialize(color)
    @color = color
    @unicode = unicode
  end

  def unicode; end

  def all_possible_moves; end

  def to_s
    "#{color}#{unicode} #{RESET_TERMINAL}"
  end
end
