# Represents Player
class Player
  attr_reader :name, :pieces

  def initialize(name, pieces_set)
    @name = name
    @pieces = pieces_set
  end
end
