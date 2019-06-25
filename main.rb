# frozen_string_literal: true

require_relative 'locale'
require_relative 'cli'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'card'
require_relative 'deck'

BlackJack::Cli.new.start
