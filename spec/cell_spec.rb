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

  end

end