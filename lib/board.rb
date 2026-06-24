class Board
  require_relative 'moves'
  include Moves
  attr_reader :board

  def initialize
    @board = { 
      a: ['a', ' ', ' ', ' '],
      b: ['b', ' ', ' ', ' '],
      c: ['c', ' ', ' ', ' ']
    }
    @turn = 0
  end
  
  def add_piece(column, row)
    @board[column][row] = get_piece
  end

  def get_piece
    @turn += 1
    if @turn % 2 == 0
      'O'
    else 
      'X'
    end
  end

  def board
        <<~TEXT
      a     b     c  
         |     |     
   1  #{@board[:a][1]}  |  #{@board[:b][1]}  |  #{@board[:c][1]}  
    _____|_____|_____
         |     |     
   2  #{@board[:a][2]}  |  #{@board[:b][2]}  |  #{@board[:c][2]}  
    _____|_____|_____
         |     |     
   3  #{@board[:a][3]}  |  #{@board[:b][3]}  |  #{@board[:c][3]}  
         |     |     
    TEXT
  end

end