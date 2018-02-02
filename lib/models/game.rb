require "byebug"
require_relative "./user"

class Game
  attr_accessor :mode, :level, :computer_players, :human_players, :rule

  def initialize(mode_code, rule = 4 )
    @mode = mode_code.to_i
    @level = 1 #default
    @computer_players = []
    @human_players = []
    @rule = rule
  end

  def self.validate_int_input(input, limitation)
    if input.to_i.between?(1, limitation)
      return input.to_i
    else
      puts "#{input} is an invalid input. Please input an integer (1-#{limitation})"
      validate_int_input(gets.chomp, limitation)
    end
  end

  def setup
    case @mode
      when 1 #PVE
        puts 'How many computers do you want to play with?  Please input an integer.'
        com_numbers =  self.class.validate_int_input(gets.chomp, 2)
        puts 'Which level(1 - 10) do you want to play? 1: Easy. 10: Hard.'
        @level = self.class.validate_int_input(gets.chomp, 10)
        for n in 1..com_numbers
          @computer_players.push(ComputerPlayer.new(@level ,"c#{n}"))
        end
        @human_players.push(HumanPlayer.new("P1"))
      when 2 #PVP
        puts 'How many players together?  Please input an integer.'
        players_numbers =  self.class.validate_int_input(gets.chomp, 3)
        for n in 1..players_numbers
          @human_players.push(HumanPlayer.new("P#{n}"))
        end
    end
  end

  def start(board)
    puts 'Game started!'
    board.state = 'processing'
    while board.state.eql?('processing')
      # human player insert
      human_players_insert(board)
      break unless board.state.eql?('processing')
      # computer insert
      computer_players_insert(board)
    end
  end

  def human_players_insert(board)
    @human_players.each do |hp|
      break unless board.state.eql?('processing')
      hp.insert_token(board)
    end
  end

  def computer_players_insert(board)
    @computer_players.each do |cp|
      break unless board.state.eql?('processing')
     cp.insert_token(board)
    end
  end
end