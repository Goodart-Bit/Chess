# frozen_string_literal: true

# Board Chess Class
class Board < Hash
  DIMENSIONS = 8
  def to_s
    board_st = ''
    (DIMENSIONS - 1).downto(0) do |row|
      0.upto(DIMENSIONS - 1) do |col|
        square_piece = self[[col, row]].nil? ? '  ' : self[[col, row]].to_s
        board_st += " [#{square_piece.center(3)}] "
      end
      board_st += "\n"
    end
    board_st
  end

  # TODO: ERASE BELOW

  <<-DOC
  def place_piece(piece, pos = [0, 0])
    return unless valid_input?(pos)

    @squares[pos] = piece
  end

  def move_piece(current_pos, next_pos)
    return unless valid_input?(current_pos) && valid_input?(next_pos, validate_empty: true)

    @squares[next_pos] = @squares[current_pos]
    @squares[current_pos] = nil
  end

  def valid_input?(pos, validate_empty: false)
    if validate_empty # true if square is empty and valid position
      @squares[pos].nil? && (COLS.include?(pos[0]) && COLS.include?(pos[1]))
    else
      COLS.include?(pos[0]) && COLS.include?(pos[1])
    end
  end
  DOC
end
