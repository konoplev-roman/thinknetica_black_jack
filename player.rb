# frozen_string_literal: true

# BlackJack
module BlackJack
  # Player
  class Player
    attr_reader :name, :bank

    def initialize(name)
      @name = name

      @bank = BANK_SIZE
    end

    # New hand with two cards
    def new_hand(cards)
      @hand = cards
    end

    # Take cards
    def take(cards)
      @hand += cards
    end

    # Make a bet
    def bet
      @bank -= BET_SIZE

      BET_SIZE
    end

    # Win a bank
    def win(bank)
      @bank += bank
    end

    # The value points of each card:
    # from two to ten - from 2 to 10, respectively
    # the ACE - 1 or 11 (11 until the total amount of not more than 21, then 1)
    # the King, Queen and Jack - 10
    def points
      points = @hand.map(&:points).sum

      points -= 10 if hand_has_ace? && points > 21

      points
    end

    def to_s
      "#{@name} ($#{@bank})"
    end

    # Show cards face down
    def open_print_hand
      puts "#{self}. #{@hand.join(', ')} - #{points} #{POINTS}"
    end

    # Reset the wishes of the player
    def tern
      @wants_open_cards = false
      @wants_take_card = false
    end

    def wants_open_cards
      @wants_open_cards = true
    end

    def wants_open_cards?
      @wants_open_cards
    end

    def wants_take_card
      @wants_take_card = true
    end

    def wants_take_card?
      @wants_take_card
    end

    def can_take_cards?
      @hand.size < 3
    end

    def cant_take_cards?
      !can_take_cards?
    end

    # If the player scored more than 21 points
    def overkill?
      points > 21
    end

    private

    def hand_has_ace?
      @hand.any? { |c| c.rank == ACE }
    end
  end
end
