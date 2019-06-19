# frozen_string_literal: true

# BlackJack
module BlackJack
  # Dealer
  class Dealer < Player
    # Show cards face up
    def secret_print_hand
      puts "#{self}. #{@hand.map { '*' }.join(', ')}"
    end

    def tern
      # Reset the wishes of the player
      super

      wants_take_card if can_take_cards?
    end

    def can_take_cards?
      @hand.size < 3 && points < 17
    end
  end
end
