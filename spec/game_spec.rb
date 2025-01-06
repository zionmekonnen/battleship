require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require './lib/game'
require 'rspec'
require 'pry'

RSpec.describe Player do 
    before (:each) do
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @board = Board.new
        @human_player = Player.new
        @game = Game.new
        @cell_1 = @board.cells["A1"]
        @cell_2 = @board.cells["A2"]
        @cell_3 = @board.cells["A3"]

    end
    it 'exists and can initialize' do
        expect(Game.new).to be_a(Game)
        expect(@game.human_player).to be_a(Player)
        expect(@game.computer_player).to be_a(Player)
    end

    
end    
