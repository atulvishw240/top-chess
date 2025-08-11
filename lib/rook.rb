require_relative "ansi_codes"
require_relative "position"
require_relative "piece"

# Represents Rook
class Rook
  attr_accessor :position
  attr_reader :color, :unicode

  def initialize(color)
    @color = color
    @unicode = "\u{265C}"
  end
end
