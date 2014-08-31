# blackjack_oop.rb

# Requirements
# - Dealer has a deck of cards. The cards are shuffled and dealt to the Dealer and Player. The player and dealer calculate their hands. If dealer has 21, game is over. If player has 21, player wins. If both have 21, they tie (push). If neither, play continues

# If play continues, player is asked to hit or stay. If player hits, new card is dealt and new caluclation made for <21, ==21 or >21. If <21, player can hit or stay. If ==21, player wins or ties is dealer aslo has 21. If >21 player loses.

# If player stays, dealer takes turn. Dealer must hit if <=16, and wil stay at >=17. If dealer, busts, palyer wins. If dealer stays at >= 17 and does not bust, compare score to player. Player with higher score wins. Game resets.

# Major nouns:
# Deck, Player, Dealer, Hand, Game

class DeckOfCards
  attr_accessor :deck, :suits, :cards
    
  def initialize
    self.suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
    self.cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
  end

  def shuffle
    self.deck = cards.product(suits)
    deck.shuffle!
  end
end


class Players
  attr_accessor :gambler, :dealer

  def initailize
  end

end



