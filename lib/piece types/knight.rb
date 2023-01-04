# frozen_string_literal: true

require_relative '../piece'
# Knight Chess Piece
class Knight < Piece
  include StaticMovePeaker

  MOVES = [%i[up left], %i[up right], %i[down left], %i[down right],
           %i[left up], %i[left down], %i[right up], %i[right down]].freeze

  def get_possible_moves(pos)
    MOVES.map do |move|
      possible_pos = peak(move[0], pos, 2, MOVE_LIMIT)
      peak(move[1], possible_pos, 1, MOVE_LIMIT) if possible_pos
    end.reject(&:nil?)
  end

  def to_s
    @color == :white ? '♘' : '♞'
  end
end
