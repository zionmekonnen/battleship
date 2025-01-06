require './lib/ship'
require './lib/cell'
require './lib/board'
require 'rspec'
require 'pry'
require './lib/player'

RSpec.describe Player do 
    before (:each) do
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @board = Board.new
        @human_player = Player.new
        @cell_1 = @board.cells["A1"]
        @cell_2 = @board.cells["A2"]
        @cell_3 = @board.cells["A3"]

    end
    
    it 'exists' do 
    expect(@human_player).to be_a(Player)
    end
    
    it 'can initialize' do 
        expect(@human_player.coordinates_shot_at).to eq([])
        expect(@human_player.ships_owned).to eq([])
    end

end