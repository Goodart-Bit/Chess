# frozen_string_literal: true

require_relative '../piece'
# Rook Chess Piece
class Rook < Piece
  include DynamicMovePeaker

  def get_possible_moves(pos)
    peak_sides(pos, MOVE_LIMIT)
  end

  def to_s
    @color == :white ? '♖' : '♜'
  end
end
