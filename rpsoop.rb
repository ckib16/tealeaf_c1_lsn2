# Set up hands
# Ask player to chose
# Ask computer to chose
# Display results
# Evaluate winner
# Display winner
# Ask if want to play again
# If yes loop, if no quite

class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') ||
(@value == 's' && another_hand.value == 'p')
      1
    else
      -1
    end
  end

  def display_winning_message
    case @value
    when 'p'
      puts "Paper wraps rock!"
    when 's'
      puts "Scissors cut paper!"
    when 'r'
      puts "Rock bashes Scissors!"
    end
  end
end

class Player

  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    puts "#{player} currently has a choice of #{self.hand.value}"
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Pick one: r / p / s"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)

    self.hand = Hand.new(c)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end

class Game

  CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => "Scissors"}

  attr_reader :player, :computer

  def initialize
    @@player_score = 0
    @@computer_score = 0
    @player = Human.new('Chris')
    @computer = Computer.new('Enigma')
  
  end

  def compare_hands

    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      @@player_score += 1
    else 
      computer.hand.display_winning_message
      @@computer_score += 1
    end
    puts "Player's score is #{@@player_score} and computer's score is #{@@computer_score}."
  end

  def play
    begin
      player.pick_hand
      puts "#{player.name} picks #{CHOICES[player.hand.value]}"
      computer.pick_hand
      puts "#{computer.name} picks #{CHOICES[computer.hand.value]}"
      compare_hands
    end until @@computer_score == 3 || @@player_score ==3
  end
end

Game.new.play



