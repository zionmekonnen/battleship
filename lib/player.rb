class Player 
    attr_reader :coordinates_shot_at, :ships_owned
    def initialize(board)
        @coordinates_shot_at = []
        @ships_owned = []
        @board = board
     end

     def human_place_ships
        
        loop do
            @board.render(true)
            puts "Place cruiser ship (3 spaces)"
            input = gets.chomp
            coordinates = input.split


            #Need to make sure coordinates match the ship length, and valid placement
            if @board.place(ship, coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end

        loop do
            @board.render(true)
            puts "Place submarine ship (2 spaces)"
            input = gets.chomp
            coordinates = input.split


            #Need to make sure coordinates match the ship length, and valid placement
            if @board.place(ship, coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end

     end

     def computer_place_ships
        #We need random coordinates, and a ship
        loop do
            computer_coordinate_1 = @board.cells.keys.sample
            orientation = ["horizontal", "vertical"].sample

            if orientation == "horizontal"
                coordinates = find_horizontal_coordinates(computer_coordinate_1, ship.length)
            else
                coordinates = find_vertical_coordinates(computer_coordinate_1, ship.length)
            end

            if @board.place(ship, coordinates) == true
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

     
end