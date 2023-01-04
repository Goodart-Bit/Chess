# frozen_string_literal: true

require_relative '../lib/piece types/pawn'

describe Pawn do
  subject(:pawn) { described_class.new(:black) }
  let(:board_dimensions) { 7 }
  describe '#possible_moves' do
    context 'when is on the middle of the board. already moved' do
      let(:pos) do
        middle = board_dimensions / 2
        [middle, middle]
      end
      it 'returns expected possible moves when moved' do
        pawn.moved = true
        default_moves =	[[3, 4]]
        attack_moves =	[[2, 4], [4, 4]]
        expected_possible_moves = [default_moves, attack_moves]
        pawn_calculated_moves = pawn.get_possible_moves(pos)
        expect(pawn_calculated_moves).to match_array(expected_possible_moves)
      end
    end
    context 'when is on the start position [5,1]' do
      let(:pos) { [5, 1] }
      it 'returns expected possible moves when not moved' do
        default_moves =	[[5, 3], [5, 2]].reverse
        attack_moves = [[4, 2], [6, 2]]
        expected_possible_moves = [default_moves, attack_moves]
        pawn_calculated_moves = pawn.get_possible_moves(pos)
        expect(pawn_calculated_moves).to match_array(expected_possible_moves)
      end
    end
  end
  describe '#filter_moves' do
    context 'when is on the start position [5,1]' do
      let(:pos) { [5, 1] }
      let(:possible_moves) { pawn.get_possible_moves(pos) }
      let(:enemy_color) { pawn.color == :black ? :white : :black }

      it 'returns expected possible moves when not moved, blocked in front but can eat an enemy' do
        enemy_pawn = instance_double(Pawn, color: enemy_color)
        ally_pawn = instance_double(Pawn, color: pawn.color)
        board = { [4, 2] => ally_pawn, [5, 2] => enemy_pawn, [6, 2] => enemy_pawn }
        attack_moves = [[6, 2]]
        expected_filtered_moves = attack_moves # there shouldn't be default moves
        expect(pawn.moves_in_board(possible_moves, board)).to match_array(expected_filtered_moves)
      end
    end
  end
end
