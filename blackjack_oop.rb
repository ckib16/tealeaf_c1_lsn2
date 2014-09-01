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
    case suit
      when 'H' then 'Hearts'
      when 'D' then 'Diamonds'
      when 'C' then 'Clubs'
      when 'S' then 'Spades'
    end
  end
end


class Deck
  attr_accessor :cards

  def initailize
    @cards = []
    ['H', 'D', 'C', 'S'].each do |suit|
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
      puts "=> #{card}"
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

deck = Deck.new

binding.pry

puts "What's your name, stranger?"
name_input = gets.chomp

player = Player.new(name_input)
dealer = Dealer.new

player.add_card(deck.deal_one)
dealer.add_card(deck.deal_one)
player.add_card(deck.deal_one)
dealer.add_card(deck.deal_one)

player.show_hand
dealer.show_hand




