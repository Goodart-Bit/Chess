# frozen_string_literal: true

require_relative 'board'
require_relative 'piece'
Dir["#{__dir__}/pieces/*.rb"].sort.each { |file| require_relative file}
# Board Chess Class
class Game
  def initialize
    @board = Board.new
    populate_board
  end

  def print_turn_game
    print @board.to_s
  end

  private

  def populate_board
    back_row_pieces = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
    front_row_piece = [Pawn]
    populate_row(0, back_row_pieces, :white)
    populate_row(1, front_row_piece, :white)
    populate_row(Board::DIMENSIONS - 1, back_row_pieces, :black)
    populate_row(Board::DIMENSIONS - 2, front_row_piece, :black)
  end

  def populate_row(row_idx, pieces, color)
    piece_count = 0
    Board::DIMENSIONS.times do |col_idx|
      piece_count = 0 if piece_count >= pieces.length - 1
      @board[[col_idx, row_idx]] = pieces[piece_count].new(color)
      piece_count += 1
    end
  end
end
