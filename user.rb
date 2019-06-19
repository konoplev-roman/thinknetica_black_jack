# frozen_string_literal: true

# BlackJack
module BlackJack
  # User
  class User < Player
    # For the user, the cards are always face down
    alias secret_print_hand open_print_hand

    def tern
      # Reset the wishes of the player
      super

      print_help

      case gets.to_i
      when 1 then wants_take_card
      when 2 then wants_open_cards
      end
    end

    private

    def print_help
      puts HELP
      print SELECT
    end
  end
end
