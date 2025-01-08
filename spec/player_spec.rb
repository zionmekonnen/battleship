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
        @board_human = Board.new
        @board_computer = Board.new
        @human_player = Player.new(@board_human, @board_computer)
        # @cell_1 = @board.cells["A1"]
        # @cell_2 = @board.cells["A2"]
        # @cell_3 = @board.cells["A3"]

    end
    
    it 'exists' do 
        expect(@human_player).to be_a(Player)
    end
    
    it 'can initialize' do 
        expect(@human_player.coordinates_shot_at).to eq([])
        expect(@human_player.ships_owned).to eq([])
    end

    it 'can create ships' do
        @human_player.create_ship("Cruiser", 3)
        @human_player.create_ship("Destroyer", 4)
        expect(@human_player.ships_owned.length).to eq(2)
        expect(@human_player.ships_owned[0].name).to eq("Cruiser")
        expect(@human_player.ships_owned[0].length).to eq(3)
        expect(@human_player.ships_owned[1].name).to eq("Destroyer")
        expect(@human_player.ships_owned[1].length).to eq(4)
    end

    it 'can find horizontal and vertical coordinates' do
        expect(@human_player.find_horizontal_coordinates("A3", 2)).to eq(["A3", "A4"])
        expect(@human_player.find_vertical_coordinates("C1", 3)).to eq(["C1", "D1", "E1"])
    end

    it 'can determine if all ships are sunk for a player' do
        @human_player.ships_owned = [@cruiser, @submarine]
        3.times do
            @cruiser.hit
        end
        expect(@human_player.all_ships_sunk?).to be(false)
        2.times do
            @submarine.hit
        end
        expect(@human_player.all_ships_sunk?).to be(true)
    end

    #All other methods either require user input or are random, and can't be tested

end