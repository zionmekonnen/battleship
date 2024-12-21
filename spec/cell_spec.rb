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

  it 'places ship in cell' do
    @cell.place_ship(@cruiser)
    expect(@cell.ship).to eq(@cruiser)
  end

  it 'cell is not empty once a ship is placed' do
    @cell.place_ship(@cruiser)
    expect(@cell.empty?).to be(false)
  end
  
  it 'initially has not been fired upon' do
    expect(@cell.fired_upon?).to be(false)
  end

  it 'decreases ship health when fired upon' do
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    expect(@cell.ship.health).to eq(2)
    expect(@cell.fired_upon?).to be(true)
  end

  

end