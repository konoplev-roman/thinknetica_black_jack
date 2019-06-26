# frozen_string_literal: true

# BlackJack
module BlackJack
  # Deck
  class Deck
    def initialize
      ranks = [*(2..10), Card::JACK, Card::QUEEN, Card::KING, Card::ACE]
      suits = [Card::CLUBS, Card::DIAMONDS, Card::HEARTS, Card::SPADES]

      @cards = []

      ranks.each do |rank|
        suits.each do |suit|
          @cards.push(Card.new(rank, suit))
        end
      end

      @cards.shuffle!
    end

    def shift
      @cards.shift
    end
  end
end
