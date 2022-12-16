# frozen_string_literal: true

# Piece Movement Module
module Move
  def go(direction, pos, length)
    peaked_pos = case direction
                 when :up then [pos[0], pos[1] + length]
                 when :down then [pos[0], pos[1] - length]
                 when :left then [pos[0] - length, pos[1]]
                 when :right then [pos[0] + length, pos[1]]
                 end
    assert_pos(peaked_pos) ? peaked_pos : nil
  end

  def go_diagonally(v_dir, h_dir, pos, length)
    peaked_pos = case [v_dir, h_dir]
                 when %i[up left] then [pos[0] + length, pos[1] - length]
                 when %i[up right] then [pos[0] + length, pos[1] + length]
                 when %i[down left] then [pos[0] - length, pos[1] - length]
                 when %i[down right] then [pos[0] - length, pos[1] + length]
                 end
    assert_pos(peaked_pos) ? peaked_pos : nil
  end

  def assert_pos(peaked_pos)
    peaked_pos.all? { |axis| axis.between?(0, 7) } ? true : false
  end
end
