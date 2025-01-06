class Game 
    attr_reader :human_player, :computer_player
    def initialize 
        @human_player = Player.new
        @computer_player = Player.new
    end

    def run_game()
        game_intro
        game_setup
        take_turns
        game_ending
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
    
end