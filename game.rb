# frozen_string_literal: true

# BlackJack
module BlackJack
  # Game
  class Game
    attr_reader :user, :dealer

    def initialize(user, dealer)
      @user = user
      @dealer = dealer

      @deck = Deck.new

      # Each player clears his hand and takes 2 cards from the shuffled deck
      players.each do |p|
        p.hand = Hand.new

        2.times { p.hand.take(@deck.shift) }
      end

      # Each player makes a bet in the common Bank
      @bank = make_bet
    end

    # Players bets are deducted from their bank and added to the game bank
    def make_bet
      players.map { |p| p.bet(BET_SIZE) }.sum
    end

    def players
      [@user, @dealer]
    end

    def turn
      players.each do |player|
        player.hand.take(@deck.shift) if player.wants_take_card?
      end
    end

    # The game ends when someone goes bankrupt
    def end?
      players.any?(&:bankrupt?)
    end

    # The turn ends when the players have 3 cards
    # or if the user wants to open the cards
    def turn_end?
      players.all?(&:cant_take_cards?) || players.any?(&:wants_open_cards?)
    end

    # If there are several winners, it is a draw
    def decide_winner
      winner.is_a?(Array) ? draw(winner) : win(winner)
    end

    def winner
      # If the player scored more than 21 points (overkill), the dealer won
      return @dealer if not_losers.empty?

      # If not the loser player one, then he won
      return not_losers.first if not_losers.one?

      # If there are several players who have not lost,
      # the winner is the one who scored the most points,
      # or a draw with the same number of points
      return not_losers if same_score?

      not_losers.max_by { |p| p.hand.points }
    end

    # In case of a draw, players divide the bank equally
    def draw(players)
      players.each do |player|
        player.win(@bank / players.size)
      end

      players
    end

    # The winning player takes the bank
    def win(player)
      player.win(@bank)

      player
    end

    # Players who do not have a overkill
    def not_losers
      players.reject { |p| p.hand.overkill? }
    end

    def same_score?
      not_losers.map { |p| p.hand.points }.uniq.size == 1
    end
  end
end
