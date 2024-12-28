require './lib/ship'
require './lib/cell'
require './lib/board'
require 'rspec'
require 'pry'

RSpec.describe Cell do
  before (:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cell = Cell.new("B4")
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")

    @board = Board.new
  end

  it 'board exists' do
    expect(@board).to be_a(Board)
  end

  it 'has cells' do
    expect(@board.cells).to be_a(Hash)
    expect(@board.cells.length).to eq(16)
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

end
