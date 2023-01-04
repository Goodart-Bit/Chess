# frozen_string_literal: true

require_relative '../piece'
# King Chess Piece class
class King < Piece
  include StaticMovePeaker
  MOVES = %i[up down left right] +
          [%i[up left], %i[up right], %i[down left], %i[down right]].freeze

  def get_possible_moves(pos)
    (directional_moves(pos) + diagonal_moves(pos)).reject(&:nil?)
  end

  def directional_moves(pos)
    MOVES[0..3].map { |dir| peak(dir, pos, 1, MOVE_LIMIT) }
  end

  def diagonal_moves(pos)
    MOVES[4..].map do |dir_set|
      possible_move = peak(dir_set[0], pos, 1, MOVE_LIMIT)
      peak(dir_set[1], possible_move, 1, MOVE_LIMIT) unless possible_move.nil?
    end
  end

  def in_check?(board)
    enemy_pieces = board.values.reject(&:nil?).filter { |piece| piece.color != @color }
    enemies_possible_moves = enemy_pieces.map do |piece|
      piece_pos = board.key(piece)
      piece.check_moves(piece_pos, board)
    end.flatten(1)
    enemies_possible_moves.any? { |move_pos| board[move_pos] == self }
  end

  def in_check_mate?(board)
    return unless in_check?(board)

    self_pos = board.key(self)
    possible_moves = check_moves(self_pos, board)
    possible_moves.all? do |move|
      aux_board = board.dup
      aux_board[self_pos] = nil
      aux_board[move] = self
      in_check?(aux_board)
    end
  end

  def to_s
    @color == :white ? '♔' : '♚'
  end
end
