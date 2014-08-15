# Set up hands
# Ask player to chose
# Ask computer to chose
# Display results
# Evaluate winner
# Display winner
# Ask if want to play again
# If yes loop, if no quite

class Player

  attr_accessor :hand, :human_hand, :computer_hand

  def initialize
    @@hand = {human_hand: nil, computer_hand: nil}
  end

  CHOICES = ["R", "P", "S"]
end

class Human < Player
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def human_picks(hp)
    puts "Chose one: (R/P/S)"
    begin
      players_input = gets.chomp.upcase.to_s
    end until CHOICES.include?(players_input)  # disregard non r/p/s inputs
    hc[self.human_hand] = players_input
    puts "You chose #{hc[self.human_hand}"
    hc
  end

end

class Computer < Player
  def initialize
  end

  def computer_picks
    options = ["R", "P", "S"]
    self.computer_hand = options.sample
    puts "The computer picks #{computer_choice}."
  end
end

class RPS

  def start_game
    puts "welcome to Rock, Paper, Scissors"  
    puts "What is your name?"
    name_input = gets.chomp
    player = Human.new(0, name_input)
  end
end

rps = RPS.new
rps.start_game