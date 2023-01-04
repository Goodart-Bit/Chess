# frozen_string_literal: true

require_relative '../lib/piece types/king'

describe King do
  subject(:king) { described_class.new(:white) }
  describe '#check?' do
    context 'when located in [6, 6]' do
      let(:pos) { [6, 6] }

      it 'returns true when an enemy can capture him' do
        enemy_bishop = double('bishop', color: :black)
        enemy_pos = [0, 0]
        enemy_moves = []
        pos[0].times { |axis| enemy_moves << [axis + 1, axis + 1] }
        check_board = { pos => king, enemy_pos => enemy_bishop }
        allow(enemy_bishop).to receive(:check_moves).with(enemy_pos, check_board).and_return(enemy_moves)
        expect(king).to be_in_check(check_board)
      end

      it "returns false when an enemy can't capture him" do
        enemy_pawn = double('pawn', color: :black)
        enemy_pos = [4, 4]
        enemy_moves = [[4, 3], [4, 2]]
        no_check_board = { pos => king, enemy_pos => enemy_pawn }
        allow(enemy_pawn).to receive(:check_moves).with(enemy_pos, no_check_board).and_return(enemy_moves)
        expect(king).to_not be_in_check(no_check_board)
      end
    end
  end
end
