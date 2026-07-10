# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do
  subject(:game) { described_class.new }

  describe '#play_game' do
    before do
      allow(game).to receive(:take_turn)
      allow(game).to receive(:tie?)
      allow(game).to receive(:winner?)
    end

    context 'when game is a tie' do
      before do
        allow(game).to receive(:tie?).and_return(true)
      end

      xit 'exits loop when game is a tie' do
      end
    end

    context 'when game is won' do
      before do
        allow(game).to receive(:winner?).and_return(true)
      end

      it 'exits loop when game is won' do
        expect(game).to receive(:finish_game).once
        game.play_game
      end
    end

    context 'when game is won after 5 turns' do
      before do
        allow(game).to receive(:take_turn)
        allow(game).to receive(:tie?).and_return(false)
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
end
