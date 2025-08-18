# Represents Player
class Player
  attr_reader :name, :set

  def initialize(name, set)
    @name = name
    @set = set
  end

  def select_piece(board, poss_selections)
    puts "Enter the coordinates of a piece to select"
    puts "The coordinates should be entered in the format (row,col): "
    selection = gets.chomp.split(",").map(&:to_i)

    if poss_selections.include?(selection)
      position = Position.new(selection[0], selection[1])
      piece = board.get_piece(position)
      return piece
    end

    puts "The coordinates you entered are not correct. Try again!!"
    select_piece(poss_selections)
  end
end
