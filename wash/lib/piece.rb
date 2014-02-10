class Piece

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def black?
    @color == 'b'
  end

  def opposite_color
    black? ? 'white' : 'black'
  end
end

class Pawn < Piece

  def valid_move_for?(movement, position)
    movement.pawn_row?(position, black?) || movement.pawn_capture?(black?)
  end
end

class Knight < Piece

  def valid_move_for?(movement, _)
    movement.knight?
  end
end

class Bishop < Piece

  def valid_move_for?(movement, position)
    movement.diagonal?(position)
  end
end

class Rook < Piece

  def valid_move_for?(movement, position)
    movement.row_or_col?(position)
  end
end

class Queen < Piece

  def valid_move_for?(movement, position)
    movement.row_or_col?(position) || movement.diagonal?(position)
  end
end

class King < Piece

  def valid_move_for?(movement, _)
    movement.king?
  end
end
