# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do
  subject(:game) { described_class.new }

  describe '#play_game' do
    before do
      allow(game).to receive(:take_turn)
      allow(game).to receive(:tie?)
      allow(game).to receive(:winner?)
      allow(game).to receive(:finish_game)
    end

    context 'when game is a tie' do
      before do
        allow(game).to receive(:tie?).and_return(true)
      end

      it 'exits loop when game is a tie' do
        game.play_game
        expect(game).to have_received(:finish_game)
      end
    end

    context 'when game is won' do
      before do
        allow(game).to receive(:winner?).and_return(true)
      end

      it 'exits loop when game is won' do
        game.play_game
        expect(game).to have_received(:finish_game)
      end
    end

    context 'when game is won after 5 turns' do
      before do
        allow(game).to receive(:winner?).and_return(false, false, false, false, true)
      end

      it 'ends on turn 5' do
        game.play_game
        expect(game.turn).to eq(5)
      end
    end
  end

  describe '#tie?' do
    before do
      game.turn = 9
      game.move = ['a', 1]
      game.board = {
        'a' => %w[a O X X],
        'b' => %w[b X O O],
        'c' => %w[c X O X]
      }
    end

    it 'returns true if there is no winner and it is turn 9' do
      expect(game.tie?).to be true
    end

    it 'returns false if it is not turn 9' do
      game.turn = 8
      expect(game.tie?).to be false
    end

    it 'returns false if there is a winner' do
      game.board = {
        'a' => %w[a X X O],
        'b' => %w[b X O O],
        'c' => %w[c X O X]
      }
      expect(game.tie?).to be false
    end
  end

  describe '#row?' do
    before do
      game.board = {
        'a' => %w[a X X X],
        'b' => %w[b X O X],
        'c' => %w[c X X X]
      }
    end

    it 'returns true if all pieces of last move\'s row are the same' do
      game.move = ['a', 1]
      expect(game.row?).to be true
    end

    it 'returns false if all pieces of last move\'s row are not the same' do
      game.move = ['b', 1]
      expect(game.row?).to be false
    end
  end

  describe '#column?' do
    before do
      game.board = {
        'a' => %w[a X X X],
        'b' => %w[b X O X],
        'c' => %w[c X X X]
      }
    end

    it 'returns true if all pieces of last move\'s column are the same' do
      game.move = ['a', 1]
      expect(game.column?).to be true
    end

    it 'returns false if all pieces of last move\'s column are not the same' do
      game.move = ['a', 2]
      expect(game.column?).to be false
    end
  end

  describe '#tlbr?' do
    it 'returns true if top-left to bottom-right diagonal are all the same and not blank' do
      game.board = {
        'a' => %w[a X X O],
        'b' => %w[b O X X],
        'c' => %w[c O O X]
      }
      expect(game.tlbr?).to be true
    end

    context 'returns false if top-left to bottom-right diagonal are not all the same or blank' do
      it 'all are not the same' do
        game.board = {
          'a' => %w[a O O X],
          'b' => %w[b X X O],
          'c' => %w[c X O X]
        }
        expect(game.tlbr?).to be false
      end

      it 'all are blank' do
        game.board = {
          'a' => ['a', ' ', 'X', 'X'],
          'b' => ['b', 'X', ' ', 'O'],
          'c' => ['c', 'O', 'O', ' ']
        }
        expect(game.tlbr?).to be false
      end
    end
  end

  describe '#trbl?' do
    it 'returns true if top-right to bottom-left diagonal are all the same and not blank' do
      game.board = {
        'a' => %w[a O X X],
        'b' => %w[b O X X],
        'c' => %w[c X O O]
      }
      expect(game.trbl?).to be true
    end

    context 'returns false if top-right to bottom-left diagonal are not all the same or blank' do
      it 'all are not the same' do
        game.board = {
          'a' => %w[a X O X],
          'b' => %w[b X X O],
          'c' => %w[c O O X]
        }
        expect(game.trbl?).to be false
      end

      it 'all are blank' do
        game.board = {
          'a' => ['a', 'X', 'O', ' '],
          'b' => ['b', 'X', ' ', 'O'],
          'c' => ['c', ' ', 'O', 'X']
        }
        expect(game.trbl?).to be false
      end
    end
  end

  describe '#fetch_move' do
    before do
      allow(game).to receive(:gets).and_return('a 1')
    end

    it 'returns the first letter and number of player input as an array' do
      result = game.fetch_move
      expect(result).to eq(['a', 1])
    end
  end

  describe '#take_turn' do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:add_piece)
      game.board = {
        'a' => ['a', 'X', 'O', ' '],
        'b' => ['b', 'X', ' ', 'O'],
        'c' => ['c', ' ', 'O', 'X']
      }
    end

    context 'when user inputs an invalid move twice, then a valid move' do
      before do
        invalid_1 = ['a', 1]
        invalid_2 = ['c', 9]
        valid = ['a', 3]
        allow(game).to receive(:fetch_move).and_return(invalid_1, invalid_2, valid)
      end

      it 'completes the loop and puts an error message twice' do
        error = "Sorry, I didn't quite get that."
        game.take_turn
        expect(game).to have_received(:puts).with(error).twice
      end
    end
  end
end
