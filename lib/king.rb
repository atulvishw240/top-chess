require_relative "ansi_codes"
require_relative "position"
require_relative "piece"
# Represents King
class King
  attr_accessor :position
  attr_reader :color, :unicode

  def initialize(color)
    @color = color
    @unicode = "\u{265A}"
  end
end
