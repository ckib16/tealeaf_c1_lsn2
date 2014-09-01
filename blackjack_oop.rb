# blackjack_oop.rb

# Requirements
# - Dealer has a deck of cards. The cards are shuffled and dealt to the Dealer and Player. The player and dealer calculate their hands. If dealer has 21, game is over. If player has 21, player wins. If both have 21, they tie (push). If neither, play continues

# If play continues, player is asked to hit or stay. If player hits, new card is dealt and new caluclation made for <21, ==21 or >21. If <21, player can hit or stay. If ==21, player wins or ties is dealer aslo has 21. If >21 player loses.

# If player stays, dealer takes turn. Dealer must hit if <=16, and wil stay at >=17. If dealer, busts, palyer wins. If dealer stays at >= 17 and does not bust, compare score to player. Player with higher score wins. Game resets.

# Major nouns:
# Deck, Player, Dealer, Hand, Game

require 'rubygems'
require 'pry'

class Card
  attr_accessor :suit, :face_value
    
  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def pretty_output
    "The #{face_value} of #{find_suit}"
  end

  def find_suit
    ret_val = case suit
                when 'H' then 'Hearts'
                when 'D' then 'Diamonds'
                when 'S' then 'Spades'
                when 'C' then 'Clubs'
              end
    ret_val
  end
end


class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def size
    cards.size
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card.pretty_output}"
    end
    puts "---- Total is: #{total} ----"
  end

  def total
    face_values = cards.map{|card| card.face_value}

    total = 0
    face_values.each do |val|
      if val == 'A'
        total += 11
      else
          total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end

    #Fix for the correct value of Aces
    face_values.select{|val| val == 'A'}.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > 21
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(n)
    @name = n
    @cards = []
  end

end

class Dealer
  include Hand

  attr_accessor :name, :cards

  def initialize
    @name = 'Dealer'
    @cards = []
  end
end

######## Game engine from procedural ########

class Blackjack

  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new("player_name_placeholder")
    @dealer = Dealer.new
  end

  def start_and_deal
    

    puts "What's your name, stranger?"
    player.name = gets.chomp

    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)
    player.add_card(deck.deal_one)
    dealer.add_card(deck.deal_one)

    player.show_hand
    dealer.show_hand
  end

  def check_blackjack #Check for blackjack at start of game#
    if player.total && dealer.total == 21
      puts "You both hit blackjack. It's a push"
      exit
    end

    if dealer.total == 21
      puts "Dealer hits Blackjack. You lose."
      exit
    end

    if player.total == 21
      puts "Nice! You hit blackjack. You win."
      exit
    end
  end

  def player_turn
    while player.total < 21
      puts "What do you want to do? 1)Hit 2)Stay?"
      hit_or_stay = gets.chomp

      if !["1","2"].include?(hit_or_stay)
        puts "Sorry, please enter 1 (Hit) or 2 (stay)"
        next
      end

      if hit_or_stay == "2"
        puts "You've chosen to stay."
        break
      end

    #hit - can refactor for method
      hit_card = deck.deal_one
      puts "You hit and get the card: #{hit_card.pretty_output}"
      player.cards << hit_card
      puts "Your new total is #{player.total}"

      if player.total == 21
        puts "Nice! You hit blackjack. You win."
      elsif player.total > 21
        puts "Oh, snap! Looks like you busted. You lose."
        exit
      end
    end
  end

  def dealer_turn
    while dealer.total <17
    #hit
      hit_card = deck.deal_one
      puts "Dealer hits and get the card: #{hit_card.pretty_output}"
      dealer.cards << hit_card
      dealer.total
      puts "Dealer's new total is #{dealer.total}"

    if dealer.total == 21
        puts "Damn! Dealer hit blackjack. You Lose."
      elsif dealer.total > 21
        puts "Dealer busted. You win."
        exit
      end
    end
  end

  def compare_hands
    puts 
    puts "Dealers cards are:"
    dealer.cards.each do |card|
      puts "=> #{card.pretty_output}"
    end
    puts "Dealers total is #{dealer.total}"
    puts ""

    puts "Players cards are:"
    player.cards.each do |card|
      puts "=> #{card.pretty_output}"
    end
    puts "Players total is #{player.total}"
    puts ""

    if player.total > dealer.total
      puts "You win!"
    elsif player.total < dealer.total
      puts "You lose."
    else
      puts "It's a push, you tie."
    end
  end
end

game = Blackjack.new
game.start_and_deal
game.player_turn
game.dealer_turn
game.compare_hands
