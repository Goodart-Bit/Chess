# frozen_string_literal: true

require_relative 'piece'
# Knight Chess Piece
class Knight < Piece
  def possible_moves(pos)
    possible_moves = []
    possible_moves.concat [move_up(pos), move_up(pos, go_left: false)]
    possible_moves.concat [move_down(pos), move_down(pos, go_left: false)]
    possible_moves.concat [move_left(pos), move_left(pos, go_up: false)]
    possible_moves.concat [move_right(pos), move_right(pos, go_up: false)]
    possible_moves.reject(&:nil?) # select moves that are not nil (from Move module @ assert_pos)
  end

  def to_s
    @color == :white ? '♘' : '♞'
  end

  private

  def move_up(pos, go_left: true)
    if go_left
      multi_move(:up, :left, 2, 1, pos) # Returns mutated array with moved positions, #move from super
    else
      multi_move(:up, :right, 2, 1, pos)
    end
  end

  def move_down(pos, go_left: true)
    if go_left
      multi_move(:down, :left, 2, 1, pos)  # Returns mutated array with moved positions, #move from super
    else
      multi_move(:down, :right, 2, 1, pos)
    end
  end

  def move_left(pos, go_up: true)
    if go_up
      multi_move(:up, :left, 1, 2, pos)
    else
      multi_move(:down, :left, 1, 2, pos)
    end
  end

  def move_right(pos, go_up: true)
    if go_up
      multi_move(:up, :right, 1, 2, pos)
    else
      multi_move(:down, :right, 1, 2, pos)
    end
  end
end
