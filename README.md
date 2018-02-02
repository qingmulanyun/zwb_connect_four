# ZwbConnectFour

Code practice with connect 4 game. You can choose game mode(PVE/PVP/PVEVP, play with multiple computers or play with multiple human players).Choose computer level from 1-10. 1: dumb. 10: smart. Core: Board model is an array of arrays.
win check is after each insert token action. Prevent from checking whole elements.

Currently, set default board 6 rows and 7 cols. Can be changed to x * y size board by editing `bin/connect4.rb` with `board = Board.new(x, y)`



## Usage

Go to root path and run `ruby bin/connect4.rb`

## Test

Go to root path and run `rspec`

## Not Implemented

1. Game mode 3 PVEVP, play with computers and human players.
2. More different level computer players

## Todo

Finish it during lunch break, not much time to add more unit tests and more features.

1. more specs.
2. add more different level computer players.
3. add restart feature for Game model.
