module ChessChimp
  module Pieces  
    class Piece
      def initialize(color, square)
      end
    end

    class King < Piece
    end

    class Queen < Piece
    end

    class Rook < Piece
    end

    class Bishop < Piece
    end

    class Knight < Piece
    end

    class Pawn < Piece
    end

    class Empty < Piece
    end
  end
end