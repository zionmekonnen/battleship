require 'pry'
class Player 
    attr_reader :coordinates_shot_at, :ships_owned
    def initialize(board_human, board_computer)
        @coordinates_shot_at = []
        @ships_owned = []
        @board_human = board_human      
        @board_computer = board_computer
    end

    def create_ship(name, length)
        @ships_owned << Ship.new(name, length)
    end

    def human_place_ships
        cruiser = create_ship("Cruiser", 3)
        submarine = create_ship('Submarine', 2)
        loop do
            puts @board_human.render(true)
            puts "Place submarine ship (2 spaces)"
            input = gets.chomp
            coordinates = input.split


            #Need to make sure coordinates match the ship length, and valid placement
            if @board_human.place(@ships_owned[1], coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end

        loop do
            puts @board_human.render(true)
            puts "Place cruiser ship (3 spaces)"
            input = gets.chomp
            coordinates = input.split

            #Need to make sure coordinates match the ship length, and valid placement
            if @board_human.place(@ships_owned[0], coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end

    
    end

    def computer_place_ships
        #We need random coordinates, and a ship
        cruiser = create_ship("Cruiser", 3)
        submarine = create_ship('Submarine', 2)
        loop do
            computer_coordinate_1 = @board_computer.cells.keys.sample
            orientation = ["horizontal", "vertical"].sample

            if orientation == "horizontal"
                coordinates = find_horizontal_coordinates(computer_coordinate_1, @ships_owned[0].length)
            else
                coordinates = find_vertical_coordinates(computer_coordinate_1, @ships_owned[0].length)
            end

            if @board_computer.place(@ships_owned[0], coordinates) == true
                break
            end
        end
        loop do
            computer_coordinate_1 = @board_computer.cells.keys.sample
            orientation = ["horizontal", "vertical"].sample

            if orientation == "horizontal"
                coordinates = find_horizontal_coordinates(computer_coordinate_1, @ships_owned[1].length)
            else
                coordinates = find_vertical_coordinates(computer_coordinate_1, @ships_owned[1].length)
            end

            if @board_computer.place(@ships_owned[1], coordinates) == true
                break
            end
        end
    end

    def find_horizontal_coordinates(computer_coordinate_1, length)
        first_number = computer_coordinate_1.slice(1, computer_coordinate_1.length - 1).to_i
        number_array = (first_number..(first_number + length - 1)).to_a
        
        number_array.map do |number|
            computer_coordinate_1.slice(0, 1) + number.to_s
        end
    end

    def find_vertical_coordinates(computer_coordinate_1, length)
        first_letter = computer_coordinate_1.slice(0, 1)
        letter_array = (first_letter..(first_letter.ord + length - 1).chr).to_a

        letter_array.map do |letter|
            letter + computer_coordinate_1.slice(1, computer_coordinate_1.length - 1)
        end
    end

    def human_fire_upon_coordinates
        input = ''
        loop do
            p 'Enter the coordinates where you would like to create devastation!:'
            loop do 
                input = gets.chomp
                break if @board_computer.valid_coordinate?(input) == true
                p "Please enter a valid coordinate:"
            end
            
            if @board_computer.cells[input].fired_upon? == false 
                break
            end
            puts "I said enter a coordinate you haven't fired upon before!"
        end

       if  @board_computer.cells[input].empty? == true 
        puts "Your shot at #{input} was a miss!"
       elsif @board_computer.cells[input].empty? == false && @board_computer.cells[input].ship.sunk? == true
        puts "Your shot at #{input} sunk the ship!"
       else 
        puts "Your shot at #{input} was a hit!"

       end
        @board_computer.cells[input].fire_upon
    end

    def computer_fire_upon_coordinates
        computer_coordinate_1 = ''
        loop do 
            computer_coordinate_1 = @board_human.cells.keys.sample
            if @board_human.cells[computer_coordinate_1].fired_upon? == false
                break
            end
        end
        @board_human.cells[computer_coordinate_1].fire_upon

        if  @board_human.cells[computer_coordinate_1].empty? == true 
                puts "My shot at #{computer_coordinate_1} was a miss!"
        elsif @board_human.cells[computer_coordinate_1].empty? == false && @board_human.cells[computer_coordinate_1].ship.sunk? == true
            puts "My shot at #{computer_coordinate_1} sunk the ship!"
        else 
            puts "My shot at #{computer_coordinate_1} was a hit!"
    
        end
    end

    def all_ships_sunk?
        @ships_owned.all? do |ship|
           ship.sunk?
        end
    end

     
end