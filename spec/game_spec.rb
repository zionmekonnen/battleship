require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'
require 'rspec'
require 'pry'

RSpec.describe Game do 
    before (:each) do
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @board_human = Board.new
        @board_computer = Board.new
        @game = Game.new

    end

    it 'exists and can initialize' do
        expect(Game.new).to be_a(Game)
    end

    #All other methods at some point require human interaction, and therefore cannot be tested
end    
