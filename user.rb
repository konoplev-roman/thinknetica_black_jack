# frozen_string_literal: true

# BlackJack
module BlackJack
  # User
  class User < Player
    def wants_turn(wish)
      reset_wishes

      send(wish)
    end
  end
end
