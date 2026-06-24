require_relative 'lib/board'
require_relative 'lib/moves'

game = Moves.new_game
game.take_turn(:a, 1)
game.take_turn(:b, 1)

game = Moves.new_game
game.take_turn(:a, 2)
game.take_turn(:b, 2)
puts game.board

#prompt for player input (letter, number)
#if spot chosen is occupied, give error and prompt again
#if turn number is odd place X, even place O -- increment turn number
#play_game method that calls a play_turn method then checks for win state/stalemate
#