require_relative 'movement'
require_relative 'piece'

class Move

  def initialize(position, square0, square1)
    @position = position
    @square0 = square0
    @square1 = square1
    @movement = Movement.new(@square0, @square1)
  end

  def piece_encoded_to_move?
    @position.piece_encoded_at(@square0)
  end

  def opposite_color?(piece_encoded0, piece_encoded1)
    piece_encoded0.chr != piece_encoded1.chr
  end

  def target_square_vacant_or_opposite_color(piece_encoded_to_move)
    target = @position.piece_encoded_at(@square1)
    return true unless target
    opposite_color? piece_encoded_to_move, target
  end

  def king_in_check_after_move?(piece)
    position_after_move = @position.after_move(@square0, @square1)
    opposing_piece_squares = position_after_move.squares_occupied_by_opposite_color(piece.opposite_color)
    king_square = position_after_move.king(piece.color)
    opposing_piece_squares.detect do |square|
      o = Move.new(position_after_move, square, king_square)
      o.valid?(false)
    end
  end

  def valid?(check_king_p = true)
    str = piece_encoded_to_move?
    return unless str && target_square_vacant_or_opposite_color(str)
    piece = piece_new(str)
    return unless piece.valid_move_for?(@movement, @position)
    return true unless check_king_p
    !king_in_check_after_move?(piece)
  end

  def piece_new(str)
    enum = str.chars
    color, kind = enum[0], enum[1]
    case kind
    when 'P'
      Pawn.new(color)
    when 'N'
      Knight.new(color)
    when 'B'
      Bishop.new(color)
    when 'R'
      Rook.new(color)
    when 'Q'
      Queen.new(color)
    when 'K'
      King.new(color)
    end
  end
end
