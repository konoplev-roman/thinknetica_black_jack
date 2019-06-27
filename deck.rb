# frozen_string_literal: true

# BlackJack
module BlackJack
  # Deck
  class Deck
    def initialize
      @cards = []

      Card::RANKS.each do |rank|
        Card::SUITS.each do |suit|
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
