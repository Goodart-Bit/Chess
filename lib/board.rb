# frozen_string_literal: true

# Board Chess Class
class Board < Hash
  DIMENSIONS = 8
  ROW_LAYOUT = "● #{'[ ● ]' * DIMENSIONS}"

  CHESS_NOTATION_DICT = ('A'..'H').to_a.each_with_object({}) do |row_letter, dictionary|
    DIMENSIONS.times { |col| dictionary["#{row_letter}#{col + 1}"] = [col, row_letter.ord - 65] }
    dictionary
  end

  def translate(input_pos)
    case input_pos
    when String
      CHESS_NOTATION_DICT[input_pos]
    when Array
      CHESS_NOTATION_DICT.key(input_pos)
    else
      raise 'Invalid input to translate'
    end
  end

  def to_s
    board_st = ''
    board_letters = CHESS_NOTATION_DICT.keys.map { |notation_st| notation_st[0] }.uniq
    (DIMENSIONS - 1).downto(0) do |row|
      row_items = [board_letters.pop]
      row_items += get_row(row)
      board_st += "#{fill_row_layout(row_items)}\n"
    end
    board_st + fill_row_layout([' '] + (1..DIMENSIONS).to_a).gsub('[', ' ').gsub(']', ' ')
  end

  def mark(positions_to_mark, color = :white)
    marked_board = dup
    positions_to_mark.each do |pos|
      marked_piece = self[pos].nil? ? '●'.colorize(color) : self[pos].to_s.colorize(:red)
      marked_board[pos] = marked_piece
    end
    marked_board
  end

  def color(pieces_to_color, color)
    colored_board = dup
    pieces_to_color.each do |piece|
      piece_pos = key(piece)
      colored_board[piece_pos] = piece.to_s.colorize(color)
    end
    colored_board
  end

  private

  def fill_row_layout(items)
    board_line_sample = ROW_LAYOUT.split('')
    board_line_sample.each_index.reduce('') do |result_st, idx|
      char = board_line_sample[idx]
      if char == '●'
        overrider_char = items.empty? ? board_line_sample[idx] : items.shift.to_s
        char = overrider_char
      end
      result_st + char
    end
  end

  def get_row(row_n)
    row_items = []
    0.upto(DIMENSIONS - 1) do |col|
      square_item = self[[col, row_n]].nil? ? ' ' : self[[col, row_n]].to_s
      row_items << square_item
    end
    row_items
  end
end
