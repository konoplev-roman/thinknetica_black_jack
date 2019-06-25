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

    attr_reader :rank, :suit, :points

    def initialize(rank, suit, points)
      @rank = rank
      @suit = suit
      @points = points
    end

    def to_s
      "#{rank}#{suit}"
    end
  end
end
