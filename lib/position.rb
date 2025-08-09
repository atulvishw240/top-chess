# Value Object i.e. meant to be pass around in our application
class Position
  attr_accessor :row, :col
  
  def initialize(row, col)
    @row = row
    @col = col
  end
end