class Position

  attr_reader :squares_occupied, :white, :black

  def initialize
    @squares_occupied = {}
    @white = {}
    @black = {}
  end

  def [](key)
    squares_occupied[key] ||= {}
  end

  def color_index_bind(col, row, piece_encoded)
    chars = piece_encoded.chars
    color = chars[0]
    rank = chars[1]
    square = "#{col}#{row}"
    if color == 'w'
      @white[rank] = square
    else
      @black[rank] = square
    end
  end

  def square_bind(col, row, piece_encoded)
    return unless col && row
    self[col][row] = piece_encoded
    color_index_bind(col, row, piece_encoded)
  end

  def piece_encoded_at(square)
    enum = square.chars
    @squares_occupied[enum[0]][enum[1].to_i] if @squares_occupied[enum[0]]
  end

  def color_index_delete(piece_encoded)
    chars = piece_encoded.chars
    color = chars[0]
    rank = chars[1]
    color == 'w' ? @white.delete(rank) : @black.delete(rank)
  end

  def square_delete(col, row, piece_encoded)
    return unless col && row
    self[col][row] = nil
    color_index_delete(piece_encoded)
  end

  def after_move(square0, square1)
    piece_encoded = piece_encoded_at(square0)
    ary0 = square0.chars
    square_delete(ary0[0], ary0[1].to_i, piece_encoded)
    ary1 = square1.chars
    square_bind(ary1[0], ary1[1].to_i, piece_encoded)
    self
  end

  def squares_occupied_by_opposite_color(color)
    color == 'white' ? @white.values : @black.values
  end

  def king(color)
    color == 'w' ? @white['K'] : @black['K']
  end
end
