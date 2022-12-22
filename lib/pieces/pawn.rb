# frozen_string_literal: true

require_relative '../piece'
# Chess Pawn Piece
class Pawn < Piece
  include StaticMovePeaker
  attr_accessor :moved, :attack_mode

  def initialize(color)
    super
    @moved = false
  end

  def get_possible_moves(pos, attack_sides = [])
    feasible_moves = []
    feasible_moves << simple_peak(:up, 1, pos)
    attack_sides.each { |side| multi_peak(:up, side, 1, 1, pos) }
    feasible_moves << simple_peak(:up, 2, pos) unless moved
    filter_possible_moves(feasible_moves)
  end

  # TODO: transform feature after reaching opponent's side

  def to_s
    @color == :white ? '♙' : '♟︎'
  end
end
