require_relative 'board'
require_relative 'move'

class Core

  def moves_input_to_lines(name_w_ext)
    File.read(input_file_path name_w_ext).lines
  end

  def validate_move(line, position)
    squares = line.split
    o = Move.new(position, squares[0], squares[1])
    o.valid? ? "LEGAL\n" : "ILLEGAL\n"
  end

  def write_to_file(str, output_name = 'results.txt')
    File.open("../output/#{output_name}", 'w') do |f|
      f.puts str
    end
  end

  def validate_for(board_file, moves_file)
    board = Board.new(board_file)
    moves = moves_input_to_lines(moves_file)
    results = ''
    moves.each { |move| results << validate_move(move, board.position_fresh) }
    write_to_file(results)
  end

private

  def input_file_path(name_w_ext)
    File.expand_path "../../input/#{name_w_ext}", __FILE__
  end
end

# integration tests
# Core.new.validate_for('complex_board.txt', 'cm_1.txt')
# Core.new.validate_for('simple_board.txt', 'simple_moves.txt')
# Core.new.validate_for('complex_board.txt', 'complex_moves.txt')
# Core.new.validate_for('exposed_check_board.txt', 'exposed_check_moves.txt')
