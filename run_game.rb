require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'
require 'rspec'
require 'pry'

game = Game.new
game.run_game 