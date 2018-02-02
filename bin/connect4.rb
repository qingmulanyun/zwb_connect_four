#!/usr/bin/env ruby
require "byebug"
require "bundler/setup"
require "zwb_connect_four"

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require "pry"
# Pry.start

require "./lib/models/board"
require "./lib/models/game"

puts 'Please choose your Game Mode:'
puts '1. PVE(play with computers)'
puts '2. PVP(play with other players)'
# puts '3. PVEVP(play with other players and cumputers)'

game_mode = Game.validate_int_input(gets.chomp, 2)
game = Game.new(game_mode)
game.setup

board = Board.new(6, 7)
board.render

game.start(board)