require './lib/ship'
require "RSpec"
require 'pry'

RSpec.describe Ship do
    before (:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end

    it 'exists' do
        expect(@cruiser).to be_a(Ship)
    end

    it 'can initialize name and length' do 
        expect(@cruiser.name).to eq("Cruiser")
        expect(@cruiser.length).to eq(3)
    end

    it 'has initial health eq to length' do
        expect(@cruiser.health).to eq(3)
    end

    it 'ship is initially not sunk' do
        expect(@cruiser.sunk?).to be(false)
    end

    it 'ship looses health when hit' do
        @cruiser.hit
        expect(@cruiser.health).to eq(2)
        @cruiser.hit 
        expect(@cruiser.health).to eq(1)
        expect(@cruiser.sunk?).to be(false)
    end

    it 'sinks when takes hit equal to length' do 
        @cruiser.hit
        @cruiser.hit
        @cruiser.hit
        expect(@cruiser.health).to eq(0)
        expect(@cruiser.sunk?).to be(true)
    end
end