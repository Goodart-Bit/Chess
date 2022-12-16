# frozen_string_literal: true

require_relative 'piece'
# King Chess Piece class
class King < Piece
  def possible_moves(pos)
    possible_moves = []
    directions = %i[up down left right]
    directions.each { |dir| possible_moves << simple_move(dir, 1, pos) }
    directions[0..1].each do |v_dir| # the first two positions contain vertical dirs, the last two, horizontal dirs
      possible_moves << multi_move(v_dir, directions[2], 1, 1, pos)
      possible_moves << multi_move(v_dir, directions[3], 1, 1, pos)
    end
    possible_moves.reject(&:nil?)
  end

  def to_s
    @color == :white ? '♔' : '♚'
  end
end
