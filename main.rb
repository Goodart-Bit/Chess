# frozen_string_literal: true

require_relative 'board'
Dir["./pieces/*.rb"].each { |file| require_relative file }
require_relative 'possible_moves_graph'

def print_path(path, game_board)
  puts 'start'.upcase
  game_board.print_board
  (path.length - 1).times do |move_i|
    puts "move #{move_i + 1}".upcase
    current_pos = path[move_i]
    next_pos = path[move_i + 1]
    game_board.move_piece(current_pos, next_pos)
    game_board.print_board
  end
end

game_board = Board.new
knight = Knight.new(:black)
king = King.new(:white)
game_board.place_piece(king)
graph = PossibleMovesGraph.new(king)
graph.knight_moves([0, 0], [7, 7])
