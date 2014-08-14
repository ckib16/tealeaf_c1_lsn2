# Set up hands
# Ask player to chose
# Ask computer to chose
# Display results
# Evaluate winner
# Display winner
# Ask if want to play again
# If yes loop, if no quite

class Player

  attr_accessor :hand

  def initialize
    @hand = []
  end
end

class Human < Player

  attr_accessor :human_hand, :name

  def initialize(h, n)
    @human_hand = hand << h
    @name = n
  end
end

class Computer < Player

  attr_accessor :computer_hand

  def initialize(c)
    @computer_hand = hand << computer_hand
  end
end

class RPS

  attr_accessor :human_choice, :computer_choice

  def start_game
    puts "welcome to Rock, Paper, Scissors"  
    puts "What is your name?"
    name_input = gets.chomp
    player = Player.new(name_input)
  end

  def human_picks
    puts "Please pick R / P / S"
    human_choice = gets.chomp.to_s.upcase
    puts "The human picks #{human_choice}."
  end

def computer_picks
    options = ["R", "P", "S"]
    computer_choice = options.sample
    puts "The computer picks #{computer_choice}."
  end
end

puts start_game