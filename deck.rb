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
          @cards.push(Card.new(rank, suit, points_by(rank)))
        end
      end

      @cards.shuffle!
    end

    def pull(size = 1)
      @cards.shift(size)
    end

    private

    def points_by(rank)
      case rank
      when 2..10 then rank
      when Card::JACK, Card::QUEEN, Card::KING then 10
      else 11 # ACE
      end
    end
  end
end
