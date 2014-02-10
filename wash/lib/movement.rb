class Movement

  def self.integer_to_char(codepoint_int) # 14-40
    [codepoint_int].pack("U*")
  end

  def initialize(square0, square1)
    @square0 = square0
    @square1 = square1
    enum0 = @square0.chars
    @col0 = enum0[0]
    @row0 = enum0[1].to_i
    enum1 = @square1.chars
    @col1 = enum1[0]
    @row1 = enum1[1].to_i
  end

  def intervening_squares_on_row_path
    min = [@row0, @row1].min + 1
    max = [@row0, @row1].max - 1
    return if max < min
    squares = []
    (min..max).each { |row| squares << "#{@col0}#{row}" }
    squares
  end

  def intervening_squares_on_col_path
    min = col_to_i([@col0, @col1].min) + 1
    max = col_to_i([@col0, @col1].max) - 1
    return if max < min
    squares = []
    (min..max).each { |col_codepoint| squares << "#{Movement.integer_to_char(col_codepoint)}#{@row0}" }
    squares
  end

  def intervening_squares_on_diagonal_path
    col_min = col_to_i([@col0, @col1].min) + 1
    col_max = col_to_i([@col0, @col1].max) - 1
    row_min = [@row0, @row1].min + 1
    return if col_max < col_min
    finish_i = col_max - col_min
    squares = []
    (0..finish_i).each { |i| squares << "#{Movement.integer_to_char(col_min + i)}#{row_min + i}" }
    squares
  end

  def path_obstructed?(squares, position)
    return unless squares
    squares.detect { |square| position.piece_encoded_at(square) }
  end

  def row_obstructed?(position)
    path_obstructed?(intervening_squares_on_row_path, position)
  end

  def col_obstructed?(position)
    path_obstructed?(intervening_squares_on_col_path, position)
  end

  def diagonal_obstructed?(position = nil)
    return unless position
    path_obstructed?(intervening_squares_on_diagonal_path, position)
  end

  def row_or_col?(position)
    if @col0 == @col1
      @row0 != @row1 && !row_obstructed?(position)
    elsif @row0 == @row1
      @col0 != @col1 && !col_obstructed?(position)
    else
      false
    end
  end

  def diagonal?(position = nil)
    return false unless @col0 != @col1 && @row0 != @row1
    distance(@row0, @row1) == col_distance(@col0, @col1) && !diagonal_obstructed?(position)
  end

  def pawn_row?(position, black_p = false)
    return false unless @col0 == @col1
    pawn_distance_range(black_p ? @row0 - @row1 : @row1 - @row0) && !row_obstructed?(position)
  end

  def pawn_capture?(black_p = false)
    return false unless diagonal?
    if black_p
      @row0 - @row1 == 1
    else
      @row1 - @row0 == 1
    end
  end

  def knight?
    return false unless @col0 != @col1 && @row0 != @row1
    if distance(@row0, @row1) == 1
      col_distance(@col0, @col1) == 2
    elsif distance(@row0, @row1) == 2
      col_distance(@col0, @col1) == 1
    end
  end

  def king?
    distance(@row0, @row1) < 2 && col_distance(@col0, @col1) < 2
  end

private

  def distance(start, finish)
    (start - finish).abs
  end

  def col_to_i(str)
    str.codepoints[0]
  end

  def col_distance(col0, col1)
    distance(col_to_i(col0), col_to_i(col1))
  end

  def pawn_distance_range(diff)
    [1, 2].include? diff
  end
end
