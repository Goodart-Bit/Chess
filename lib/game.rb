# frozen_string_literal: true

require 'colorize'
require_relative 'board'
require_relative 'piece'
Dir["#{__dir__}/piece types/*.rb"].sort.each { |file| require_relative file }
# Board Chess Class
class Game
  def initialize
    @board = Board.new
    @player_colors = %i[white black].shuffle
    populate_board
  end

  def play
    puts 'Welcome to the chess game'
    until game_over
      current_king = @board.values.find { |piece| piece&.color == @player_colors[0] && piece.is_a?(King) }
      puts 'King is in check' if current_king&.in_check?(@board)
      next_turn
    end
    opponent_king = @board.values.find { |piece| piece&.color == @player_colors[1] && piece.is_a?(King) }
    puts "#{@player_colors[1]}'s king is in check mate! \n#{@board.color([[opponent_king]], :red)}"
    puts "#{@player_colors[0]} wins"
  end

  private

  def next_turn
    @player_colors << @player_colors.shift
    puts "#{@player_colors[0]}'s turn"
    turn_piece = select_movable_piece
    turn_move = move_selection(turn_piece)
    move(turn_piece, turn_move)
  end

  def game_over
    next_player_color = @player_colors[1]
    king = @board.values.find do |piece|
      piece.is_a?(King) && piece.color == next_player_color
    end
    king&.in_check_mate?(@board)
  end

  def player_input(options_arr)
    loop do
      input = gets.chomp.upcase # always in chess notation. Ex: "A1","G6" ...
      break input if options_arr.include?(input)

      puts 'Your selection is invalid, try again'.colorize(:red)
    end
  end

  def select_movable_piece
    loop do
      selected_piece = select_piece
      piece_moves = selected_piece.check_moves(@board.key(selected_piece), @board)
      unless piece_moves.empty?
        puts "You've selected the #{selected_piece.to_s.colorize(:yellow)} " \
             "located in #{@board.translate(@board.key(selected_piece))}"
        break selected_piece
      end
      puts 'The piece you selected has no possible moves, try selecting another'.colorize(:red)
    end
  end

  def select_piece
    colorable_squares = @board.filter { |_pos, piece| piece&.color == @player_colors[0] }
    puts @board.color(colorable_squares.values, :green).to_s
    puts "Select one of the piece types highlighted in #{'• green'.colorize(:green)} to move it"
    selectable_notations = colorable_squares.keys.map { |pos| @board.translate(pos) }
    selected_piece_notation = player_input(selectable_notations)
    selected_pos = @board.translate(selected_piece_notation)
    @board[selected_pos]
  end

  def move_selection(piece)
    puts "Select one of the marked #{'● possible positions'.colorize(:blue)}"
    colored_board = @board.color([piece], :yellow)
    piece_pos = @board.key(piece)
    mark_moves = piece.check_moves(piece_pos, @board)
    puts colored_board.mark(mark_moves, :blue)
    player_input(mark_moves.map { |move_pos| @board.translate(move_pos) })
  end

  def move(piece, destination_notation)
    current_pos = @board.key(piece)
    destination_pos = @board.translate(destination_notation)
    @board[destination_pos] = piece
    piece.moved = true if piece.is_a?(Pawn)
    @board[current_pos] = nil
  end

  def populate_board
    back_row_pieces = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
    front_row_piece = [Pawn]
    populate_row(0, back_row_pieces, :white)
    populate_row(1, front_row_piece, :white)
    populate_row(Board::DIMENSIONS - 1, back_row_pieces.reverse, :black)
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
