class Cell
  attr_reader :coordinates, :fired_upon

  def initialize(coordinates)
    @coordinates = coordinates
    @ship_in_cell = nil
    @fired_upon = false 
  end

  def ship()
    @ship_in_cell
  end

  def empty?()
    if @ship_in_cell == nil
      return true
    else
      return false
    end
  end

  def place_ship(ship)
    @ship_in_cell = ship
  end
  
  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship_in_cell == nil
      return @fired_upon = true 
    else 
      ship.hit 
      return @fired_upon = true
    end

  end
end

