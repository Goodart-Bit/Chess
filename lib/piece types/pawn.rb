# frozen_string_literal: true

require_relative '../piece'
# Chess Pawn Piece
class Pawn < Piece
  include StaticMovePeaker
  attr_accessor :moved

  def initialize(color)
    super
    @moved = false
    @move = color == :white ? :up : :down
    @attack_moves = [[@move, :left], [@move, :right]]
  end

  def get_possible_moves(pos)
    [default_moves(pos), attack_moves(pos)].map { |move_set| move_set.reject(&:nil?) }
  end

  def moves_in_board(move_group, board)
    default_moves = move_group[0]
    attack_moves = move_group[1]
    filtered_moves = default_moves.each_with_object([]) do |possible_pos, possible_moves|
      break possible_moves unless board[possible_pos].nil?

      possible_moves << possible_pos
    end
    filtered_moves.concat(attack_moves.filter { |move| board[move] && board[move].color != @color })
  end

  # TODO: transform feature after reaching opponent's side

  def to_s
    '♙'
  end

  private

  def default_moves(pos)
    default_moves = [peak(@move, pos, 1, MOVE_LIMIT)]
    default_moves << peak(@move, pos, 2, MOVE_LIMIT) unless moved
    default_moves
  end

  def attack_moves(pos)
    @attack_moves.map { |move_dirs| multi_peak(move_dirs[0], move_dirs[1], 1, 1, pos) }
  end
end
