class User
  attr_accessor :role

  def initialize(role)
    @role = role
  end
end


class ComputerPlayer < User
  attr_accessor :level

  # level 1: dumb computer, level 10: smart computer

  def initialize(level, role)
    super(role)
    @level = level # dumb computer
  end

  def insert_token(board)
    unless board.draw?
      puts
      print "#{@role}'s turn."
      3.times {
        print '.'
        sleep(1)
      }
      puts
      board.accept_token(insert_per_level(board.valid_move), @role)
    end
  end

  def insert_per_level(move_scope)
    case @level
      when 1 #level 1: dumb computer
        move_scope.sample
      else
        move_scope.sample
    end
  end
end

class HumanPlayer < User
  def initialize(role)
    super(role)
  end

  def insert_token(board)
    unless board.draw?
      puts
      puts "#{@role}'s turn. Please insert a token."
      player_move = board.validate_insert(gets.chomp)
      board.accept_token(player_move, @role)
    end
  end
end