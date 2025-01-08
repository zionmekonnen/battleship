class Game 
    attr_reader :human_player, :computer_player
    def initialize 
        @board_computer = Board.new
        @board_human = Board.new
        @human_player = Player.new(@board_human, @board_computer)
        @computer_player = Player.new(@board_computer, @board_human)
    end

    def run_game()
        loop do
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
            @board_computer.render
            p '==============PLAYER BOARD=============='
            @board_human.render(true)

            @human_player.human_fire_upon_coordinates
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