# frozen_string_literal: true

require_relative 'move_peakers/static_move_peaker'
require_relative 'move_peakers/dynamic_move_peaker'
require_relative 'board'
# Super Piece class
class Piece
  MOVE_LIMIT = Board::DIMENSIONS - 1
  attr_reader :color

  def initialize(color = :white)
    @color = color
  end

  def check_moves(pos, board)
    feasible_moves = get_possible_moves(pos)
    moves_in_board(feasible_moves, board)
  end

  # def assert_pos(peaked_pos)
  #  peaked_pos.all? { |axis| axis.between?(0, LIMIT) } ? true : false
  # end
end
