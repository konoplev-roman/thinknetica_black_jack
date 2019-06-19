# frozen_string_literal: true

require_relative 'locale'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'

# BlackJack
module BlackJack
  # Cli
  class Cli
    def initialize
      print ENTER_YOUR_NAME
      name = gets.chomp

      @dealer = Dealer.new(DEALER_NAME)

      @players = []
      @players.push(User.new(name))
      @players.push(@dealer)
    end

    # The game continues until someone wins or the player exits the game
    def start
      loop do
        game

        break if game_end? || want_exit?
      end

      print_won_players
    end

    private

    def game
      # Each player clears his hand and takes 2 cards from the shuffled deck
      @deck = Deck.new
      @players.each { |p| p.new_hand(@deck.pull(2)) }

      # Each player makes a bet in the common Bank
      @bank = make_bet

      # The game consists of several turns
      loop do
        tern

        break if turn_end?
      end

      open_print_hands

      decide_winner
    end

    def decide_winner
      # If there are several winners, it is a draw
      winner.is_a?(Array) ? draw(winner) : win(winner)
    end

    def winner
      # If the player scored more than 21 points (overkill), the dealer won
      return @dealer if not_losers.empty?

      # If not the loser player one, then he won
      return not_losers.first if not_losers.one?

      # Also, there may be a draw, all players won
      return not_losers if not_losers.map(&:points).uniq.size == 1

      # Otherwise, find the winner with a lot of points
      not_losers.max_by(&:points)
    end

    # Players who do not have a overkill
    def not_losers
      @players.reject(&:overkill?)
    end

    # The winning player takes the bank
    def win(player)
      player.win(@bank)

      puts
      puts "#{player} #{WINS}!"
    end

    # In case of a draw, players divide the bank equally
    def draw(players)
      players.each do |player|
        player.win(@bank / players.size)
      end

      puts
      puts "#{DRAW}! #{players.join(', ')}"
    end

    def tern
      secret_print_hands

      @players.each do |player|
        player.tern

        break if turn_end?

        player.take(@deck.pull) if player.wants_take_card?
      end
    end

    # The turn ends when the players have 3 cards
    # or if the user wants to open the cards
    def turn_end?
      @players.all?(&:cant_take_cards?) || @players.any?(&:wants_open_cards?)
    end

    # Players bets are deducted from their bank and added to the game bank
    def make_bet
      @players.map(&:bet).sum
    end

    # Places are distributed in desc order of banks of players
    def print_won_players
      @players.sort_by(&:bank).reverse.each.with_index(1) do |player, i|
        puts "#{i}. #{player}"
      end
    end

    def secret_print_hands
      puts
      puts SECRET_HAND
      @players.each(&:secret_print_hand)
    end

    def open_print_hands
      puts
      puts OPEN_HAND
      @players.each(&:open_print_hand)
    end

    # The game ends when only one (or no one) player has the money
    def game_end?
      @players.select { |p| p.bank.positive? }.size <= 1
    end

    # The game ends when the player exits the game
    def want_exit?
      puts
      print "#{WANT_EXIT} (y/N) "

      %w[y Y].include?(gets.chomp)
    end
  end
end

BlackJack::Cli.new.start
