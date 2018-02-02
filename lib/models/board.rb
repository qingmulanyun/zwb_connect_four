require "byebug"

class Board
  attr_accessor :row, :col, :body, :state

  def initialize(row, col)
    @row = row.to_i
    @col = col.to_i
    @body = Array.new()
    @col.times {
      @body.push(Array.new(@row))
    }
    @state = 'ready'
  end

  def render
    for row in 1..@row
      @body.each do |col|
       if col[row - 1].nil?
         print " •  "
       else
         print " #{col[row - 1 ]} "
       end
      end
      puts
    end
  end

  def accept_token(col, role)
    row_location = 0
    for row in (@row - 1).downto(0)
       if @body[col - 1][row].nil?
         @body[col - 1][row] = role
         puts "#{role} insert to col #{col}"
         row_location = row + 1
         break
       end
    end
    render
    win?(role, col, row_location, rule = 4)
  end

  def validate_insert(insert_col)
    if insert_col.to_i.between?(1, @col) && check_col_available?(insert_col.to_i)
      insert_col.to_i
    else
      puts "invalid move"
      validate_insert(gets.chomp)
    end
  end

  def check_col_available?(col)
    @body[col - 1][0].nil?
  end

  def win?(role, col, row, rule)
    role_container = []
    rule.times {
      role_container.push(role)
    }
    check_str = role_container.join('-')

    #check vertical                     check horizontal
    if check_vertical(col, check_str) || check_horizontal(row, check_str) || check_leftdown_to_rightup(col, row, check_str) || check_leftup_to_rightdown(col, row, check_str)
      puts
      puts "#{role} win!"
      @state = 'win'
      return true
    else
      return false
    end
  end

  def draw?
    if valid_move.size == 0
      puts
      puts 'Draw!'
      @state = 'draw'
      return true
    else
      return false
    end
  end

  def valid_move
    available_cols = []
    @body.each_with_index do |col, index|
      available_cols.push(index + 1) if col[0].nil?
    end
    available_cols
  end

  def check_vertical(col, check_str)
    @body[col - 1 ].join('-').include?(check_str)
  end

  def check_horizontal(row, check_str)
    row_container = []
    @body.each do |col_container|
      row_container.push(col_container[row - 1] )
    end
    row_container.join('-').include?(check_str)
  end

  def check_leftdown_to_rightup(col, row, check_str)
    human_row = @row - row + 1
    if human_row > col || human_row == col# left up
      virtual_container = []
      virtual_start_r = human_row - (col - 1)
      virtual_start_c = 1
      virtual_stop_r = @row
      virtual_container_length = virtual_stop_r - virtual_start_r + 1
      virtual_container_length.times  {
        virtual_container.push(@body[virtual_start_c - 1][@row - virtual_start_r])
        virtual_start_r += 1
        virtual_start_c += 1
      }
      return true if virtual_container.join('-').include?(check_str)
    else
      # right down
      virtual_container = []
      virtual_start_r = 1
      virtual_start_c = col - (human_row - 1)
      virtual_stop_c = @col
      virtual_container_length = virtual_stop_c - virtual_start_c + 1
      virtual_container_length.times  {
        virtual_container.push(@body[virtual_start_c - 1][@row - virtual_start_r])
        virtual_start_r += 1
        virtual_start_c += 1
      }
      return true if virtual_container.join('-').include?(check_str)
    end
  end

  def check_leftup_to_rightdown(col, row, check_str)
    human_row = @row - row + 1
    if human_row > @col - col || human_row == (@col - col)# right up
      virtual_container = []
      virtual_start_r = human_row - (@col - col)
      virtual_start_c = @col
      virtual_stop_r = @row
      virtual_container_length = virtual_stop_r - virtual_start_r + 1
      virtual_container_length.times  {
        virtual_container.push(@body[virtual_start_c - 1][@row - virtual_start_r])
        virtual_start_r += 1
        virtual_start_c -= 1
      }
      return true if virtual_container.join('-').include?(check_str)
    else
      # left down
      virtual_container = []
      virtual_start_r = 1
      virtual_start_c = col + (human_row - 1)
      virtual_stop_c = 1
      virtual_container_length = virtual_stop_c - virtual_start_c + 1
      virtual_container_length.times  {
        virtual_container.push(@body[virtual_start_c - 1][@row - virtual_start_r])
        virtual_start_r += 1
        virtual_start_c -= 1
      }
      return true if virtual_container.join('-').include?(check_str)
    end
  end
end