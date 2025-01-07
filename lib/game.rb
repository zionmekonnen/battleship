class Game 
    attr_reader :human_player, :computer_player
    def initialize 
        @board = Board.new
        @human_player = Player.new(@board)
        @computer_player = Player.new(@board)
    end

    def run_game()
       if game_intro == false 
        return 
       end
        game_setup
        player_win_status = take_turns
        if player_win_status == true
            p "You are so amazing, you WIN!"
        else 
            p "You lose! Better luck next time."
        end

    end

    def game_intro()
        puts "Welcome to BATTLESHIP"
        puts "Enter p to play. Enter q to quit."
        input = gets.chomp
        
        if input == "p"
            return true 
        elsif input == 'q'
            puts 'GoodBye!'
            return false 
        else 
            puts "Invalid Selection, Rerun the Game."
            return false 
        end
    end
     def game_setup()
        puts 'Please place your 2 ships, The Cruiser is three units long and the Submarine is two units long.'

        @human_player.human_place_ships
        @computer_player.computer_place_ships
    end
    def take_turns
        loop do
            p "=============COMPUTER BOARD============="
            @board.render
            p '==============PLAYER BOARD=============='
            @board.render(true)

            p 'Enter the coordinates where you would like to create devastation!:'

            loop do 
                input = gets.chomp
                break if @board.valid_coordinate?(input) == true
                p "Please enter a valid coordinate:"
            end
            @human_player.human_fire_upon_coordinates(input)
            @computer_player.computer_fire_upon_coordinates
            
            if @human_player.all_ships_sunk? == true 
                return false
            end
            if @computer_player.all_ships_sunk? == true 
                return true
            end
            

        end

    end
end