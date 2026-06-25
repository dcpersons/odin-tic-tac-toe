require_relative 'lib/board'

loop do
  game = Board.new_game
  game.play_game
  puts 'Would you like to play again? Y/N'
  again = gets.chomp
  break unless again.downcase == 'y'
end
