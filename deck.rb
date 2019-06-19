# frozen_string_literal: true

# BlackJack
module BlackJack
  # Deck
  class Deck
    def initialize
      ranks = [*(2..10), JACK, QUEEN, KING, ACE]
      suits = [CLUBS, DIAMONDS, HEARTS, SPADES]

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
      when JACK, QUEEN, KING then 10
      else 11 # ACE
      end
    end
  end
end
