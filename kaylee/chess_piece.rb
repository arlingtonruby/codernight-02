class ChessPiece
  
  
  def initialize(name, valid_moves, num_moves, superman)
    # An array of valid moves to compare against no an x,y coordinate systesms
    @name = name
    @valid_moves = valid_moves
    @num_moves = num_moves
    @superman = superman #Can he fly over pieces?

  end

  def name
    @name
  end

  def num_moves
    @num_moves
  end

  def superman
    @superman
  end

  def valid_moves
    @valid_moves
  end

  def non_piece?
    return true if self.name == "--"
    return false
  end
end