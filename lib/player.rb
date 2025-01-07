class Player 
    attr_reader :coordinates_shot_at, :ships_owned
    def initialize(board_human, board_computer)
        @coordinates_shot_at = []
        @ships_owned = []
        @board_human = board_human      
        @board_computer = board_computer
    end

    def human_place_ships
        
        loop do
            @board_human.render(true)
            puts "Place cruiser ship (3 spaces)"
            input = gets.chomp
            coordinates = input.split


            #Need to make sure coordinates match the ship length, and valid placement
            if @board_human.place(ship, coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end

        loop do
            @board_human.render(true)
            puts "Place submarine ship (2 spaces)"
            input = gets.chomp
            coordinates = input.split


            #Need to make sure coordinates match the ship length, and valid placement
            if @board_human.place(ship, coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end

    end

    def computer_place_ships
        #We need random coordinates, and a ship
        loop do
            computer_coordinate_1 = @board_computer.cells.keys.sample
            orientation = ["horizontal", "vertical"].sample

            if orientation == "horizontal"
                coordinates = find_horizontal_coordinates(computer_coordinate_1, ship.length)
            else
                coordinates = find_vertical_coordinates(computer_coordinate_1, ship.length)
            end

            if @board_computer.place(ship, coordinates) == true
                break
            end
        end
    end

    def find_horizontal_coordinates(computer_coordinate_1, length)
        first_number = computer_coordinate_1.slice(1, computer_coordinate_1.length - 1)
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

    def human_fire_upon_coordinates(input)
        loop do
            p 'Enter the coordinates where you would like to create devastation!:'
            loop do 
                input = gets.chomp
                break if @board.valid_coordinate?(input) == true
                p "Please enter a valid coordinate:"
            end
            
            if @board_computer.cells[input].fired_upon? == false 
                break
            end
            puts "I said enter a coordinate you haven't fired upon before!"
        end

        @board_computer.cells[input].fire_upon
    end
    

     
end