# Interface to convert our moves and pieces selections from the format
# row_index, col_index to filerank (i.e e1, a2, b1, etc.)
module Utility
  FILES = %w[a b c d e f g h].freeze

  private

  def to_rank(row_index)
    8 - row_index
  end

  def to_file(col_index)
    FILES[col_index]
  end

  def to_row_index(rank)
    8 - rank
  end

  def to_col_index(file)
    FILES.index(file)
  end
end
