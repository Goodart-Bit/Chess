# frozen_string_literal: true

require_relative '../piece'
# Queen Chess Piece
class Queen < Piece
  include DynamicMovePeaker

  def get_possible_moves(pos)
    peak_sides(pos, MOVE_LIMIT) + peak_diagonals(pos, MOVE_LIMIT)
  end

  def to_s
    @color == :white ? '♕' : '♛'
  end
end
