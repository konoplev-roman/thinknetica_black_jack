# frozen_string_literal: true

# BlackJack
module BlackJack
  # Player
  class Player
    attr_reader :name, :bank
    attr_accessor :hand

    def initialize(name, bank)
      @name = name

      @bank = bank
    end

    # Make a bet
    def bet(size)
      @bank -= size

      size
    end

    # Win a bank
    def win(bank)
      @bank += bank
    end

    def to_s
      "#{@name} ($#{@bank})"
    end

    def bankrupt?
      !@bank.positive?
    end

    def can_take_cards?
      @hand.cards.size < 3
    end

    def cant_take_cards?
      !can_take_cards?
    end

    # Reset the wishes of the player
    def reset_wishes
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
  end
end
