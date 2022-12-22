# frozen_string_literal: true

require_relative '../piece'
# Queen Chess Piece
class Queen < Piece
  include DynamicMovePeaker

  def get_possible_moves(pos)
    feasible_moves = []
    feasible_moves.concat peak_sides(pos, MOVE_LIMIT)
    feasible_moves.concat peak_diagonals(pos, MOVE_LIMIT)
    filter_possible_moves(feasible_moves)
  end

  def to_s
    @color == :white ? '♕' : '♛'
  end
end