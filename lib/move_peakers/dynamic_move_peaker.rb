# frozen_string_literal: true

# Piece Movement Module: Specialized in Free Movable Pieces
# such as the Rook, the Queen or the Bishop
module DynamicMovePeaker
  # limits of a figure located in the [3,5] pos of a 7x7 square =>
  # [3,7],[3,0],[0,5],[7,5]
  def peak_sides(pos, limit)
    sides_map = []
    limits = { up: [pos[0], limit], down: [pos[0], 0],
               left: [0, pos[1]], right: [limit, pos[1]] }
    limits.each_value { |limit_pos| sides_map << check_side(pos.dup, limit_pos) }
    sides_map
  end

  # diagonal-limits of a 7x7 square =>
  # [0,0],[7,7],[7,0],[0,7]
  def peak_diagonals(pos, limit)
    diagonals_map = []
    limits = { upper_left: [0, limit], upper_right: [limit, limit],
               lower_left: [0, 0], lower_right: [limit, 0] }
    limits.each_value { |limit_pos| diagonals_map << check_diagonal(pos.dup, limit_pos) }
    diagonals_map
  end

  def moves_in_board(move_group, board)
    move_group.map do |move_set|
      filtered_move_set = move_set
      move_set.each_with_index do |move_pos, idx|
        unless board[move_pos].nil?
          break filtered_move_set = board[move_pos]&.color == self.color ? move_set[0...idx] : move_set[0..idx]
        end
      end
      filtered_move_set
    end.flatten(1)
  end

  private

  <<-DOC
    #peak_side method works for only one axis. Such as the vertical axis (row), or the 
    horizontal axis (column), so the ending_pos and the start_pos must have a matching axis.
    Ex: [1,1] will never reach [2,2] unless theres a multi-axis movement (diagonal)
    Note: The difference between start_pos and ending_pos is asserted because if it returns
    the same start_pos, that they dont have axis (numbers) in common.
    [1,1] - [2,2] = [1,1] => Impossible to reach [2,2]
  DOC

  def check_side(pos, target_pos)
    return if (pos - target_pos) == pos

    side_map = []
    search_params = get_search_params(pos, target_pos)
    movable_axis = search_params[:movable_axis]
    until pos == target_pos
      pos[movable_axis] = pos[movable_axis].send(search_params[:operand], 1) # += 1 or -= 1
      side_map << [pos[0], pos[1]]
    end
    side_map
  end

  def check_diagonal(pos, limit_pos)
    return if (pos - limit_pos).empty?

    side_map = []
    search_params = get_search_params(pos, limit_pos, diagonal: true)
    loop do
      break side_map if limit_pos[0] == pos[0] || limit_pos[1] == pos[1]

      pos = [pos[0].send(search_params[:col_operand], 1),
             pos[1].send(search_params[:row_operand], 1)] # = [ pos[0] ± 1, pos[1] ± 1 ]
      side_map << pos
    end
  end

  # SEARCH_PARAMS: { movable_axis: (0 if col, 1 if row), operand: + or -}
  def get_search_params(start_pos, ending_pos, diagonal: false)
    if diagonal # diagonal movement
      col_operand = start_pos[0] < ending_pos[0] ? '+' : '-'
      row_operand = start_pos[1] < ending_pos[1] ? '+' : '-'
      return { row_operand: row_operand, col_operand: col_operand }
    end
    is_row = start_pos[1] == ending_pos[1]
    movable_axis = is_row ? 0 : 1
    operand = start_pos[movable_axis] < ending_pos[movable_axis] ? '+' : '-'
    { movable_axis: movable_axis, operand: operand }
  end
end
