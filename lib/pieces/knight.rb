# frozen_string_literal: true

require_relative '../piece'
# Knight Chess Piece
class Knight < Piece
  include StaticMovePeaker

  def get_possible_moves(pos)
    feasible_moves = []
    feasible_moves.concat [peak_up(pos), peak_up(pos, go_left: false)]
    feasible_moves.concat [peak_down(pos), peak_down(pos, go_left: false)]
    feasible_moves.concat [peak_left(pos), peak_left(pos, go_up: false)]
    feasible_moves.concat [peak_right(pos), peak_right(pos, go_up: false)]
    filter_possible_moves(feasible_moves)
  end

  def to_s
    @color == :white ? '♘' : '♞'
  end

  private

  def peak_up(pos, go_left: true)
    if go_left
      multi_peak(:up, :left, 2, 1, pos)
    else
      multi_peak(:up, :right, 2, 1, pos)
    end
  end

  def peak_down(pos, go_left: true)
    if go_left
      multi_peak(:down, :left, 2, 1, pos)
    else
      multi_peak(:down, :right, 2, 1, pos)
    end
  end

  def peak_left(pos, go_up: true)
    if go_up
      multi_peak(:up, :left, 1, 2, pos)
    else
      multi_peak(:down, :left, 1, 2, pos)
    end
  end

  def peak_right(pos, go_up: true)
    if go_up
      multi_peak(:up, :right, 1, 2, pos)
    else
      multi_peak(:down, :right, 1, 2, pos)
    end
  end
end
