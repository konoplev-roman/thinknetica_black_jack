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

    RANKS = [*(2..10), JACK, QUEEN, KING, ACE].freeze
    SUITS = [CLUBS, DIAMONDS, HEARTS, SPADES].freeze

    attr_reader :rank, :suit

    def initialize(rank, suit)
      @rank = rank
      @suit = suit
    end

    def to_s
      "#{@rank}#{@suit}"
    end

    def points
      # @formatter:off
      case @rank
      when 2..10 then @rank
      when JACK, QUEEN, KING then 10
      else 11 # ACE
      end
      # @formatter:on
    end
  end
end
