# frozen_string_literal: true

require_relative '../piece'
# King Chess Piece class
class King < Piece
  include StaticMovePeaker

  def get_possible_moves(pos)
    feasible_moves = []
    directions = %i[up down left right]
    directions.each { |dir| feasible_moves << simple_peak(dir, 1, pos) }
    directions[0..1].each do |v_dir| # the first two directions are vertical, the last two, horizontal
      feasible_moves << multi_peak(v_dir, directions[2], 1, 1, pos)
      feasible_moves << multi_peak(v_dir, directions[3], 1, 1, pos)
    end
    filter_possible_moves(feasible_moves)
  end

  def to_s
    @color == :white ? '♔' : '♚'
  end
end
