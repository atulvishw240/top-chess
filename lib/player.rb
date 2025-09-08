# Represents Player
class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def select(options)
    puts 'Enter your choice (in format e1, a2, etc.): '
    choice = gets.chomp
    return choice if options.include?(choice)

    puts 'Your entered input is incorrect!! Try again'
    select(options)
  end
end
