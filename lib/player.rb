require 'pry'
class Player 
    attr_reader :coordinates_shot_at
    attr_accessor :ships_owned          #Only used for one of the tests; otherwise not needed

    def initialize(board_human, board_computer)
        @ships_owned = []
        @board_human = board_human      
        @board_computer = board_computer

        #Variables for computer to track attack patterns
        @previous_hits = []
        @has_found_ship = false
        @is_forward = true
        @index_for_next_guess = 0
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

            if @board_human.place(@ships_owned[0], coordinates) == true
                break
            end

            puts "Invalid placement.  Please try again."
        end
    end

    def computer_place_ships
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

        # binding.pry
        
        @board_computer.cells[input].fire_upon
        if @board_computer.cells[input].empty? == true 
            puts "Your shot at #{input} was a miss!"
        elsif @board_computer.cells[input].empty? == false && @board_computer.cells[input].ship.sunk? == true
            puts "Your shot at #{input} sunk the ship!"
        else 
            puts "Your shot at #{input} was a hit!"
        end
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
        
        #This is for iteration 4 - only partially working
        # if !@has_found_ship
        #     computer_coordinate_1 = random_search_pattern()
        # else
        #     computer_coordinate_1 = targeted_hit()
        # end
        # computer_coordinate_1 = random_search_pattern()

        if @board_human.cells[computer_coordinate_1].empty? == true 
                puts "My shot at #{computer_coordinate_1} was a miss!"
        elsif @board_human.cells[computer_coordinate_1].empty? == false && @board_human.cells[computer_coordinate_1].ship.sunk? == true
            puts "My shot at #{computer_coordinate_1} sunk the ship!"
        else 
            puts "My shot at #{computer_coordinate_1} was a hit!"
        end
    end

    def random_search_pattern()
        random_row = nil
        random_column = nil

        loop do
          random_row = ("A".."D").to_a.sample
          # random_column = ""
          if ("A".."D").step(2).to_a.any?(random_row)
            random_column = ("1".."4").step(2).to_a.sample        #Only samples from 1, 3, 5, ...
          else
            random_column = ("2".."4").step(2).to_a.sample        #Only samples from 2, 4, 6, ...
          end
          random_cell = @board_human.cells[random_row + random_column]
      
          if !random_cell.fired_upon?
            random_cell.fire_upon
            # @previous_hits << random_cell if !random_cell.empty?
            # @has_found_ship = true
            break
          end
        end

        return random_row + random_column
    end

    def targeted_hit()
        #If we only had one hit, check nearest neighbors for another hit
        if @previous_hits.length == 1
            neighbor_cells = find_neighbor_cells(@previous_hits.last)    
            #Of course, only fire upon a neighbor that hasn't been incidentally fired upon initially
            while @board.cells[neighbor_cells[@index_for_next_guess]].fired_upon?
              @index_for_next_guess += 1
            end
        
            @board.cells[neighbor_cells[@index_for_next_guess]].fire_upon
            if !@board.cells[neighbor_cells[@index_for_next_guess]].empty?
              @previous_hits << neighbor_cells[@index_for_next_guess]
              @index_for_next_guess = 0
            else
              @index_for_next_guess += 1
            end
        end

        #If we have two or more hits, we need to predict the next coordinate to hit (in a line).
        #Code is incomplete here.
    end

    def find_neighbor_cells(coordinate)
        #This locates the up-to-4 neighbor valid cells.
        neighbor_coordinates = []
        coordinate_letter = coordinate.slice(0, 1)
        coordinate_number = coordinate.slice(1, coordinate.length - 1)
      
        neighbor_coordinates << (coordinate_letter.ord - 1).chr + coordinate_number
        neighbor_coordinates << (coordinate_letter.ord + 1).chr + coordinate_number
        neighbor_coordinates << coordinate_letter + (coordinate_number.ord - 1).chr
        neighbor_coordinates << coordinate_letter + (coordinate_number.ord + 1).chr
      
        #Now iterate through array and only return subset of array that includes valid coordinates:
        neighbor_coordinates.find_all do |coordinate|
          @board_human.cells[coordinate].valid_coordinate?
        end
    end

    def all_ships_sunk?
        @ships_owned.all? do |ship|
           ship.sunk?
        end
    end
end