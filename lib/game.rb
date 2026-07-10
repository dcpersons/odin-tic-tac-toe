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
        add_piece(@move[0], @move[1])
        return
      else
        puts "Sorry, I didn't quite get that."
      end
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

  def add_piece(column, row)
    @board[column][row] = @piece[(@turn % 2)]
  end

  def winner?
    column?(@move[0]) ||
      row?(@move[1]) ||
      tlbr? ||
      trbl?
  end

  def tie?
    !winner? && @turn == 9
  end

  def column?(column)
    @board[column].uniq.length == 2 && @board[column] != ' '
  end

  def row?(row)
    row = [@board['a'][row], @board['b'][row], @board['c'][row]]
    row.uniq.length == 1 && row[1] != ' '
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
         a     b     c#{'  '}
            |     |#{'     '}
      1  #{@board['a'][1]}  |  #{@board['b'][1]}  |  #{@board['c'][1]}#{'  '}
       _____|_____|_____
            |     |#{'     '}
      2  #{@board['a'][2]}  |  #{@board['b'][2]}  |  #{@board['c'][2]}#{'  '}
       _____|_____|_____
            |     |#{'     '}
      3  #{@board['a'][3]}  |  #{@board['b'][3]}  |  #{@board['c'][3]}#{'  '}
            |     |#{'     '}
    TEXT
  end
end
