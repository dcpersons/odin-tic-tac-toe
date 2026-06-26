require_relative 'lib/game'

loop do
  Game.new_game
  puts 'Would you like to play again? Y/N'
  again = gets.chomp.downcase
  break unless again == 'y'
end
