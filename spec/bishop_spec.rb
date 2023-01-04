# frozen_string_literal: true

require_relative '../lib/piece types/bishop'

describe Bishop do
  subject(:bishop) { described_class.new(:black) }
  let(:board_dimensions) { 7 }
  describe '#possible_moves' do
    context 'when is on the middle of the board' do
      let(:pos) do
        middle = board_dimensions / 2
        [middle, middle]
      end
      let(:expected_possible_moves) do
        upper_left =	[[2, 4], [1, 5], [0, 6]]
        upper_right =	[[4, 4], [5, 5], [6, 6], [7, 7]]
        lower_left =	[[2, 2], [1, 1], [0, 0]]
        lower_right =	[[4, 2], [5, 1], [6, 0]]
        [upper_left, upper_right, lower_left, lower_right]
      end
      it 'returns a hash containing the possible moves for the upper left side' do
        possible_moves = bishop.get_possible_moves(pos)
        expect(possible_moves).to include(expected_possible_moves[0])
      end
      it 'returns a hash containing exactly all possible moves' do
        possible_moves = bishop.get_possible_moves(pos)
        expect(expected_possible_moves).to match_array(possible_moves)
      end
    end
  end
  describe '#filter_moves' do
    let(:possible_moves) do
      upper_left = []
      upper_right =	[[1, 4], [2, 5], [3, 6], [4, 7]]
      lower_left = []
      lower_right = [[1, 2], [2, 1], [3, 0]]
      [upper_left, upper_right, lower_left, lower_right]
    end
    let(:game_board) do
      enemy_color = bishop.color == :black ? :white : :black
      enemy_bishop = instance_double(Bishop, color: enemy_color)
      ally_bishop = instance_double(Bishop, color: bishop.color)
      { [1, 4] => enemy_bishop, [3, 0] => ally_bishop, [3, 3] => bishop }
    end
    it 'returns filtered moves taking in account the board piece types' do
      upper_right = 	[[1, 4]]
      lower_right = 	[[1, 2], [2, 1]]
      expected_filtered_moves = upper_right + lower_right # any left move should be empty
      expect(bishop.moves_in_board(possible_moves, game_board)).to match_array expected_filtered_moves
    end
  end
end
