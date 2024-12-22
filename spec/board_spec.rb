require './lib/ship'
require './lib/cell'
require './lib/board'
require 'rspec'
require 'pry'

RSpec.describe Cell do
  before (:each) do
    @cruiser = Ship.new("Cruiser", 3)
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

end
