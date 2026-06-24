module Moves

  def self.new_game
    Board.new
  end

  def take_turn(column, row)
    if @board[column][row] == ' '
      self.add_piece(column, row)
    end
  end
end