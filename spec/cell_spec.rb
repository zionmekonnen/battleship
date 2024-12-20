require './lib/ship'
require './lib/cell'
require 'rspec'
require 'pry'

RSpec.describe Cell do
  before (:each) do
    @cruiser = Ship.new("Cruiser", 3)
    @cell = Cell.new("B4")
  end

  it 'exists' do
    expect(@cell).to be_a(Cell)
  end

  it 'returns coordinates' do
    expect(@cell.coordinates).to eq("B4")
  end

  it 'initially does not have a ship' do
    expect(@cell.ship).to eq(nil)
  end

  it 'cell is initially empty' do 
    expect(@cell.empty?).to be(true)
  end

end