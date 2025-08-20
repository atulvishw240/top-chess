# Represents Player
class Player
  attr_reader :name, :set

  def initialize(name, set)
    @name = name
    @set = set
  end

  def select_piece(poss_selections)
    puts "Enter the coordinates of a piece to select"
    puts "The coordinates should be entered in the format (row,col): "
    selection = gets.chomp.split(",").map(&:to_i)

    return selection if poss_selections.include?(selection)

    puts "The coordinates you entered are not correct. Try again!!"
    select_piece(poss_selections)
  end

  def make_move(poss_moves)
    puts "Enter the coordinates of where you would like to move your piece."
    puts "The coordinates should be in the format (row,col): "
    move = gets.chomp.split(",").map(&:to_i)

    return move if poss_moves.include?(move)

    puts "The coordinates you entered are not correct. Try again!!"
    select_move(poss_moves)
  end
end
