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

  def make_move(board, piece)
    all_moves = piece.get_possible_moves(board)
    p all_moves
    puts "Enter the coordinates of where you would like to move your piece."
    puts "The coordinates should be in the format (row,col): "
    move = gets.chomp.split(",").map(&:to_i)

    if all_moves.include?(move)
      new_position = Position.new(move[0], move[1])
      board.delete(piece)
      piece.move(new_position)
      board.update(piece)
      return
    end

    puts "The coordinates you entered are not correct. Try again!!"
    make_move(board, piece)
  end
end
