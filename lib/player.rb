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

     
end