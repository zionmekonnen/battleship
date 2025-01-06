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

    def 
end