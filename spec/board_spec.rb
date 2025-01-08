require './lib/ship'
require './lib/cell'
require './lib/board'
require 'rspec'
require 'pry'

RSpec.describe Cell do
  before (:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @board = Board.new

    @cell_1 = @board.cells["A1"]
    @cell_2 = @board.cells["A2"]
    @cell_3 = @board.cells["A3"]

  end

  it 'board exists' do
    expect(@board).to be_a(Board)
  end

  it 'has cells' do
    expect(@board.cells).to be_a(Hash)
    expect(@board.cells.length).to eq(16)
    expect(@board.cells["B4"]).to be_a(Cell)
  end

  it 'returns if coordinates are valid' do
    expect(@board.valid_coordinate?("A1")).to eq(true)
    expect(@board.valid_coordinate?("D4")).to eq(true)
    expect(@board.valid_coordinate?("A5")).to eq(false)
    expect(@board.valid_coordinate?("E1")).to eq(false)
    expect(@board.valid_coordinate?("A22")).to eq(false)
  end

  it 'makes sure that ship coordinates are valid and equal ship length' do
    expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
    expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
  end

  it 'coordinates are valid for different ship placements' do
    expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
    expect(@board.valid_placement?(@submarine, ["A1, C1"])).to be(false)
    expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
    expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
    expect(@board.valid_placement?(@cruiser, ['A1', 'B2', 'D4'])).to be(false)
    expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
    expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
    expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
    expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)

  end

  it 'places ship in cells' do
    @board.place(@cruiser, ["A1", "A2", "A3"])
    expect(@cell_1).to eq(@board.cells['A1'])
    expect(@cell_2).to eq(@board.cells['A2'])
    expect(@cell_3).to eq(@board.cells['A3'])

    expect(@cell_1.ship).to eq(@cruiser)
    expect(@cell_2.ship).to eq(@cruiser)
    expect(@cell_3.ship).to eq(@cruiser)
    expect(@cell_3.ship).to eq(@cell_2.ship)

    expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be(false)
  end

  it 'creates a board with a ship' do
    @board.place(@cruiser, ["A1", "A2", "A3"]) 
    expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'draws a board with correct hits and misses' do
    @board.place(@cruiser, ["A1", "A2", "A3"]) 
    @board.place(@submarine, ["C1", "D1"])
    expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC S . . . \nD S . . . \n")

    @board.cells["A1"].fire_upon
    @board.cells["A2"].fire_upon
    expect(@board.render(true)).to eq("  1 2 3 4 \nA H H S . \nB . . . . \nC S . . . \nD S . . . \n")
    expect(@cruiser.health).to eq(1)
    @board.cells["A3"].fire_upon
    expect(@cruiser.sunk?).to be(true)
    expect(@board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC S . . . \nD S . . . \n")

    @board.cells["D1"].fire_upon
    expect(@board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC S . . . \nD H . . . \n")

    @board.cells["A4"].fire_upon
    @board.cells["B3"].fire_upon
    expect(@board.render(true)).to eq("  1 2 3 4 \nA X X X M \nB . . M . \nC S . . . \nD H . . . \n")
  end

  #The methods is_consecutive?(), is_constant?(), and overlapping?() are private helper methods,
  #and are implicitly already tested by running valid_placement?(), etc.

end
