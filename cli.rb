# frozen_string_literal: true

# BlackJack
module BlackJack
  # Cli
  class Cli
    ENTER_YOUR_NAME = 'Enter your name: '
    DEALER_NAME = 'Dealer'
    SELECT = 'Select number: '
    SECRET_HAND = 'In the hands of players:'
    OPEN_HAND = 'Result:'
    POINTS = 'points'
    WANT_EXIT = 'Want to quit?'
    WINS = 'wins'
    DRAW = 'Draw'

    HELP = <<~HELP

      1 - Add a card
      2 - Show cards
      Other - Skip turn

    HELP

    def initialize
      @user = User.new(name, BANK_SIZE)
      @dealer = Dealer.new(DEALER_NAME, BANK_SIZE)
    end

    # The game continues until someone wins or the player exits the game
    def start
      # The game consists of several party
      loop do
        @game = Game.new(@user, @dealer)

        # The game consists of several turns
        loop do
          turn

          break if @game.turn_end?
        end

        print_results

        break if @game.end? || want_exit?
      end
    end

    private

    def turn
      secret_print_hands

      user_wish = choice

      @user.wants_turn(user_wish) if user_wish != :wants_skip_turn
      @dealer.wants_turn if user_wish != :wants_open_cards

      @game.turn
    end

    def print_results
      open_print_hands

      winner = @game.decide_winner

      puts

      if winner.is_a?(Array)
        puts "#{DRAW}! #{winner.join(', ')}"
      else
        puts "#{winner} #{WINS}!"
      end
    end

    # The game ends when the player exits the game
    def want_exit?
      puts
      print "#{WANT_EXIT} (y/N) "

      %w[y Y].include?(gets.chomp)
    end

    def name
      print ENTER_YOUR_NAME
      gets.chomp
    end

    def choice
      puts HELP
      print SELECT

      # @formatter:off
      case gets.to_i
      when 1 then :wants_take_card
      when 2 then :wants_open_cards
      else :wants_skip_turn
      end
      # @formatter:on
    end

    def secret_print_hands
      puts
      puts SECRET_HAND

      # For the user, the cards are always face down
      puts "#{@game.user}. #{open_cards(@game.user.hand)}"
      puts "#{@game.dealer}. #{secret_cards(@game.dealer.hand)}"
    end

    def open_print_hands
      puts
      puts OPEN_HAND

      puts "#{@game.user}. #{open_cards(@game.user.hand)}"
      puts "#{@game.dealer}. #{open_cards(@game.dealer.hand)}"
    end

    def open_cards(hand)
      "#{hand.cards.join(', ')} - #{hand.points} #{POINTS}"
    end

    def secret_cards(hand)
      hand.cards.map { '*' }.join(', ')
    end
  end
end
