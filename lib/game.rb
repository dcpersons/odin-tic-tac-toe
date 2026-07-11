# frozen_string_literal: true

# Board instances contain all variables and methods to play a game of tic-tac-toe
# all methods are private except for "new_game" and "play_game"
class Game
  attr_accessor :move, :turn, :board

  def initialize
    @board = {
      'a' => ['a', ' ', ' ', ' '],
      'b' => ['b', ' ', ' ', ' '],
      'c' => ['c', ' ', ' ', ' ']
    }
    @turn = 1
    @piece = %w[O X]
    @move = []
  end

  def self.new_game
    game = Game.new
    game.play_game
  end

  def play_game
    loop do
      take_turn
      break if tie? || winner?

      @turn += 1
    end
    finish_game
  end

  def take_turn
    loop do
      puts board
      @move = fetch_move
      if @board.dig(@move[0], @move[1]) == ' '
        add_piece
        break
      end
      puts "Sorry, I didn't quite get that."
    end
  end

  def finish_game
    puts board
    if tie?
      puts 'No winner this time!'
    else
      puts "Congratulations, #{@piece[(@turn % 2)]}s player wins!"
    end
  end

  def fetch_move
    puts 'Please enter your move'
    move = gets.chomp
    [move.downcase[/[a-z]/].to_s, move[/\d/].to_i]
  end

  def add_piece
    @board[@move[0]][@move[1]] = @piece[(@turn % 2)]
  end

  def winner?
    column? ||
      row? ||
      tlbr? ||
      trbl?
  end

  def tie?
    !winner? && @turn == 9
  end

  def row?
    @board[@move[0]].uniq.length == 2
  end

  def column?
    row = [@board['a'][@move[1]], @board['b'][@move[1]], @board['c'][@move[1]]]
    row.uniq.length == 1
  end

  def tlbr?
    tlbr = [@board['a'][1], @board['b'][2], @board['c'][3]]
    tlbr.uniq.length == 1 && tlbr[0] != ' '
  end

  def trbl?
    trbl = [@board['c'][1], @board['b'][2], @board['a'][3]]
    trbl.uniq.length == 1 && trbl[0] != ' '
  end

  def board # rubocop:disable Metrics/AbcSize
    <<~TEXT
         1     2     3#{'  '}
            |     |#{'     '}
      a  #{@board['a'][1]}  |  #{@board['a'][2]}  |  #{@board['a'][3]}#{'  '}
       _____|_____|_____
            |     |#{'     '}
      b  #{@board['b'][1]}  |  #{@board['b'][2]}  |  #{@board['b'][3]}#{'  '}
       _____|_____|_____
            |     |#{'     '}
      c  #{@board['c'][1]}  |  #{@board['c'][2]}  |  #{@board['c'][3]}#{'  '}
            |     |#{'     '}
    TEXT
  end
end
