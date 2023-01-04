# frozen_string_literal: true

# Piece Movement Module for statically movable pieces
module StaticMovePeaker
  def peak(direction, pos, length, limit = 7)
    peaked_pos = case direction
                 when :up then [pos[0], pos[1] + length]
                 when :down then [pos[0], pos[1] - length]
                 when :left then [pos[0] - length, pos[1]]
                 when :right then [pos[0] + length, pos[1]]
                 end
    peaked_pos if peaked_pos.all? { |axis| axis.between?(0, limit) }
  end

  def multi_peak(v_dir, h_dir, v_dist, h_dist, pos)
    return unless (v_moved_pos = peak(v_dir, pos, v_dist))

    peak(h_dir, v_moved_pos, h_dist) # bidirectional moves
  end

  def moves_in_board(move_set, board)
    move_set.select { |pos| board[pos].nil? || board[pos]&.color != @color }
  end
end
