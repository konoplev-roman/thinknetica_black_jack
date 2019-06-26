# frozen_string_literal: true

# BlackJack
module BlackJack
  # Card
  class Card
    JACK = 'J'
    QUEEN = 'Q'
    KING = 'K'
    ACE = 'A'

    CLUBS = '♣'
    DIAMONDS = '♦'
    HEARTS = '♥'
    SPADES = '♠'

    attr_reader :rank, :suit

    def initialize(rank, suit)
      @rank = rank
      @suit = suit
    end

    def to_s
      "#{rank}#{suit}"
    end

    def points
      case rank
      when 2..10 then rank
      when Card::JACK, Card::QUEEN, Card::KING then 10
      else 11 # ACE
      end
    end
  end
end
