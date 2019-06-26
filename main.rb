# frozen_string_literal: true

require_relative 'cli'
require_relative 'game'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'

# BlackJack
module BlackJack
  BANK_SIZE = 100
  BET_SIZE = 10
end

BlackJack::Cli.new.start
