# frozen_string_literal: true

require_relative 'move_peakers/static_move_peaker'
require_relative 'move_peakers/dynamic_move_peaker'
require_relative 'board'
# Super Piece class
class Piece
  MOVE_LIMIT = Board::DIMENSIONS - 1

  def initialize(color = :white)
    @color = color
  end

  def get_possible_moves(pos); end

  # def assert_pos(peaked_pos)
  #  peaked_pos.all? { |axis| axis.between?(0, LIMIT) } ? true : false
  # end

  def filter_possible_moves(feasible_moves)
    feasible_moves.reject { |move| move.nil? or !move.all? { |axis| axis.between?(0, MOVE_LIMIT) } }
  end
end
