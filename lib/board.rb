require 'pry'

class Board
  attr_reader :cells

  def initialize()
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }

    @valid_coordinate = false
  end

  def valid_coordinate?(coordinates)
    @cells.key?(coordinates)
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length 
      return false
    end

    if overlapping?(coordinates) == true
      return false
    end

    letters = []
    numbers =[]
    coordinates.each do |coordinate|
      letters << coordinate.slice(0,1)
      numbers << coordinate.slice(1,coordinate.length - 1)
    end
    return is_consecutive?(letters) && is_constant?(numbers) || is_consecutive?(numbers) && is_constant?(letters)
  end

  def place(ship, coordinates)
    #check is the placement valid 
    #is it overlapping with another ship 
    if valid_placement?(ship, coordinates)
      #if not overlapping it need to be assigned to the cell
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render(player_ownership = false)
    row_1 = "  1 2 3 4 \n"
    rows = ["A", "B", "C", "D"].map do |row|
      columns = ["1", "2", "3", "4"].map do |column|
        @cells[row + column].render(player_ownership)
      end.join(" ")
      row + " " + columns + " \n"
    end
    row_1 + rows.join
  end


  private

  def is_consecutive?(array)
    range = (array[0].ord)..(array[0].ord + array.length - 1)
    array_ord = array.map do |element|
      element.ord
    end
    if array_ord == range.to_a
      return true 
    else return false 
    end
  end

  def is_constant?(array)
    array.all? do |element|
      element == array[0]
    end
  end

  def overlapping?(coordinates)
    coordinates.any? do |coordinate|
      !@cells[coordinate].empty?
    end
  end


end