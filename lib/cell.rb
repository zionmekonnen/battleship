class Cell
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
    @ship_in_cell = nil
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
end

