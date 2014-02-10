require_relative 'position'

class Board

  def position_input_to_lines(name_w_ext)
    File.read(input_file_path name_w_ext).lines
  end

  def initialize(board_file)
    @rows = position_input_to_lines(board_file)
  end

  def index_to_column_string(i)
    (i + 10).to_s(36) # lower case letters: 'a' through 'h'
  end

  def row_to_encoded_pieces(position, row, row_index)
    squares = row.split
    squares.each_with_index do |piece_encoded, i|
      next if square_empty? piece_encoded
      position.square_bind(index_to_column_string(i), row_index, piece_encoded)
    end
    position
  end

  def position_fresh
    o = Position.new
    row_index = 8
    @rows.each do |row|
      o = row_to_encoded_pieces(o, row, row_index)
      row_index -= 1
    end
    o
  end

private

  def input_file_path(name_w_ext)
    File.expand_path "../../input/#{name_w_ext}", __FILE__
  end

  def square_empty?(str)
    str == '--'
  end
end
