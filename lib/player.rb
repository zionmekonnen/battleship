class Player 
    attr_reader :coordinates_shot_at, :ships_owned
    def initialize(board)
        @coordinates_shot_at = []
        @ships_owned = []
        @board = board
     end

     def human_place_ships

     end

     def computer_place_ships
        #We need random coordinates, and a ship
        loop do
            computer_coordinate_1 = @board.cells.keys.sample

            find_horizontal_coordinates(computer_coordinate_1)
            # find_vertical_coordinates(computer_coordinate_1)
            
            # A4, A3, A2 -> legal! (horizontal)

            # B2, B3, B4 -> legal!
            # A4, B4, C4 -> legal! (vertical)

            @board.place(ship, coordinates)
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
        letter_array = (first_letter.."Z").to_a[0, length]

        letter_array.map do |letter|
            letter + computer_coordinate_1.slice(1, computer_coordinate_1.length - 1)
        end
     end

     
end