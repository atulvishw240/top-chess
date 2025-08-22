# Value Object i.e. meant to be pass around in our application
class Position
  attr_accessor :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def valid?
    row.between?(0, 7) && col.between?(0, 7)
  end

  def ==(other)
    row == other.row && col == other.col
  end
end
