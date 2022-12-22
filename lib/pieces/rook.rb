# frozen_string_literal: true

require_relative '../piece'
# Rook Chess Piece
class Rook < Piece
  include DynamicMovePeaker

  def get_possible_moves(pos)
    feasible_moves = peak_sides(pos, MOVE_LIMIT)
    filter_possible_moves(feasible_moves)
  end

  def to_s
    @color == :white ? '♖' : '♜'
  end
end
