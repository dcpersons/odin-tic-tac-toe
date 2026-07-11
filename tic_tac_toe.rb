# frozen_string_literal: true

require_relative 'lib/game'

Game.new_game

loop do
  puts 'Would you like to play again? (y/n)'
  again = gets.chomp.downcase
  Game.new_game if again == 'y'
  break if again == 'n'

  puts 'Sorry, I didn\'t quite get that.' unless again == 'y'
end
