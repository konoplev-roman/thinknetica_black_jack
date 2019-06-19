# frozen_string_literal: true

# BlackJack
module BlackJack
  BANK_SIZE = 100
  BET_SIZE = 10

  JACK = 'J'
  QUEEN = 'Q'
  KING = 'K'
  ACE = 'A'
  CLUBS = '♣'
  DIAMONDS = '♦'
  HEARTS = '♥'
  SPADES = '♠'

  ENTER_YOUR_NAME = 'Enter your name: '
  WANT_EXIT = 'Want to quit?'
  SELECT = 'Select number: '
  DEALER_NAME = 'Dealer'
  POINTS = 'points'
  SECRET_HAND = 'In the hands of players:'
  OPEN_HAND = 'Result:'
  WINS = 'wins'
  DRAW = 'Draw'

  HELP = <<~HELP

    1 - Add a card
    2 - Show cards
    Other - Skip tern

  HELP
end
