# frozen_string_literal: true

# Piece Movement Module: Specialized in Free Movable Pieces
# such as the Rook, the Queen or the Bishop
module DynamicMovePeaker
  def peak_sides(pos, board_limit)
    sides_overview = [] # includes vertical & horizontal sides
    sides_overview.concat peak_column(pos, board_limit)
    sides_overview.concat peak_file(pos, board_limit)
  end

  def peak_diagonals(pos, board_limit)
    diagonal_overview = []
    %i[up down].each do |dir|
      diagonal_overview.concat peak_diagonal_segment(pos, dir, :left, board_limit)
      diagonal_overview.concat peak_diagonal_segment(pos, dir, :right, board_limit)
    end
    diagonal_overview
  end

  private

  def peak_column(pos, board_limit)
    col_overview = Array.new(board_limit)
    col_overview.each_index.map { |file_idx| col_overview << [pos[0], file_idx] } - pos
  end

  def peak_file(pos, board_limit)
    file_overview = Array.new(board_limit)
    file_overview.each_index.map { |col_idx| file_overview << [col_idx, pos[1]] } - pos
  end

  def peak_diagonal_segment(pos, vertical_dir, horizontal_dir, board_limit)
    aux_pos = pos.dup
    diagonal_segment = []
    while aux_pos.all? { |axis| axis.between?(1, board_limit - 1) }
      horizontal_dir == :left ? aux_pos[0] -= 1 : aux_pos[0] += 1
      vertical_dir == :up ? aux_pos[1] += 1 : aux_pos[1] -= 1
      diagonal_segment << aux_pos
    end
    diagonal_segment
  end
end
