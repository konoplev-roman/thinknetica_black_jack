# frozen_string_literal: true

# BlackJack
module BlackJack
  # Hand
  class Hand
    attr_reader :cards

    def initialize
      @cards = []
    end

    def take(card)
      @cards << card
    end

    # The value points of each card:
    # from two to ten - from 2 to 10, respectively
    # the ACE - 1 or 11 (11 until the total amount of not more than 21, then 1)
    # the King, Queen and Jack - 10
    def points
      @points = @cards.map(&:points).sum

      @points -= 10 if ace_any? && overkill?

      @points
    end

    # If the player scored more than 21 points
    def overkill?
      @points > 21
    end

    private

    def ace_any?
      @cards.any? { |c| c.rank == Card::ACE }
    end
  end
end
