# frozen_string_literal: true

require_relative '../lib/piece types/rook'

describe Rook do
  context 'when is on the middle of the board' do
    let(:pos) do
      middle = board_dimensions / 2
      [middle, middle]
    end
    subject(:rook) { described_class.new(:black) }
    let(:board_dimensions) { 7 }
    describe '#possible_moves' do
      let(:expected_possible_moves) do
        left_result =	[[0, 3], [1, 3], [2, 3]].reverse
        right_result =	[[4, 3], [5, 3], [6, 3], [7, 3]]
        up_result =	[[3, 7], [3, 6], [3, 5], [3, 4]].reverse
        down_result =	[[3, 2], [3, 1], [3, 0]]
        [left_result, right_result, up_result, down_result]
      end
      it 'returns a hash containing the possible moves for the upper side' do
        possible_moves = rook.get_possible_moves(pos)
        expect(possible_moves).to include(expected_possible_moves[2])
      end
      it 'returns a hash containing exactly all possible moves' do
        possible_moves = rook.get_possible_moves(pos)
        expect(expected_possible_moves).to match_array(possible_moves)
      end
    end
    describe '#filter_moves' do
      let(:possible_moves) do
        left_result =	[[0, 3], [1, 3], [2, 3]].reverse
        right_result =	[[4, 3], [5, 3], [6, 3], [7, 3]]
        up_result =	[[3, 7], [3, 6], [3, 5], [3, 4]].reverse
        down_result =	[[3, 2], [3, 1], [3, 0]]
        [left_result, right_result, up_result, down_result]
      end
      let(:game_board) do
        enemy_color = rook.color == :black ? :white : :black
        enemy_rook = instance_double(Rook, color: enemy_color)
        ally_rook = instance_double(Rook, color: rook.color)
        { [3, 2] => ally_rook, [3, 4] => enemy_rook, [6, 3] => enemy_rook, [3, 3] => rook }
      end
      it 'returns filtered moves taking in account the board piece types' do
        left_result =	[[0, 3], [1, 3], [2, 3]].reverse
        right_result = [[4, 3], [5, 3], [6, 3]]
        up_result = [[3, 4]]
        expected_filtered_moves = left_result + right_result + up_result # down result should be empty
        expect(rook.moves_in_board(possible_moves, game_board)).to match_array expected_filtered_moves
      end
    end
  end
end
