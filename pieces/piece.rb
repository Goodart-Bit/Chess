# frozen_string_literal: true

require_relative '../move'
# Super Piece class
class Piece
  include Move
  def initialize(color = :white)
    @color = color
  end

  private

  def simple_move(dir, dist, pos)
    go(dir, pos, dist) # unidirectional moves
  end

  def multi_move(v_dir, h_dir, v_dist, h_dist, pos)
    return unless (v_moved_pos = go(v_dir, pos, v_dist))

    go(h_dir, v_moved_pos, h_dist) # bidirectional moves
  end
end
