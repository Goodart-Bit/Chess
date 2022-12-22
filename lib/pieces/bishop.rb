# frozen_string_literal: true

require_relative '../piece'
# Bishop Chess Piece: Freely Movable
class Bishop < Piece
  include DynamicMovePeaker

  def get_possible_moves(pos)
    feasible_moves = peak_diagonals(pos, MOVE_LIMIT)
    filter_possible_moves(feasible_moves)
  end

  def to_s
    @color == :white ? '♗' : '♝'
  end
end
