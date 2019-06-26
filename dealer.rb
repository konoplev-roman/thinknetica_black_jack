# frozen_string_literal: true

# BlackJack
module BlackJack
  # Dealer
  class Dealer < Player
    def wants_turn
      reset_wishes

      wants_take_card if can_take_cards?
    end

    def can_take_cards?
      @hand.cards.size < 3 && @hand.points < 17
    end
  end
end
