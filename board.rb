# frozen_string_literal: true

# Board Chess Class
class Board
  COLS = (0..7).freeze
  LIMIT = COLS.size - 1
  attr_reader :squares

  def initialize(dimensions = 8)
    @dimensions = dimensions - 1
    @squares = {} # POSITION => piece or => nil if square is empty. Ex: [0,0] => Queen
  end

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

  def print_board
    LIMIT.downto(0) do |row|
      0.upto(LIMIT) do |col|
        square_piece = @squares[[col, row]].nil? ? '  ' : @squares[[col, row]].to_s
        print(" [#{square_piece.center(3)}] ")
      end
      puts('')
    end
  end
end
