# frozen_string_literal: true

RSpec.shared_examples 'a piece' do
  context "when is at the board's start: [1,1]" do
    let(:start_pos) { [0, 0] }
    describe '#simple_peak' do
      let(:valid_direction) { %i[up right].sample }
      let(:valid_distance) { 1 }
      context 'when a valid input is given' do
        it 'should return an array with the peaked location' do
          distance = 1
          possible_peaks = [[start_pos[0] + distance, start_pos[1]], [start_pos[0], start_pos[1] + distance]]
          piece_peak = subject.simple_peak(valid_direction, distance, start_pos)
          expect(possible_peaks).to include(piece_peak)
        end
      end
      context 'when a invalid input is given' do
        it 'returns nil if invalid direction' do
          bad_direction =  %i[down left].sample
          piece_peak = subject.simple_peak(bad_direction, valid_distance, start_pos)
          expect(piece_peak).to be_nil
        end
        it 'returns nil if invalid distance' do
          bad_distance = 8
          piece_peak = subject.simple_peak(valid_direction, bad_distance, start_pos)
          expect(piece_peak).to be_nil
        end
      end
    end
  end
end
