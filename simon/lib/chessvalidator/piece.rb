module ChessValidator
	class Piece
		attr_accessor :color

		def can_move? move, otherPiece
		end
	end

	class Pawn < Piece
		CODE = "P"
		def initialize color
			@color = color
		end
	end

	class Rook < Piece
		CODE="R"
		def initialize color
			@color = color
		end
	end

	class Knight < Piece
		CODE="N"
		def initialize color
			@color = color
		end

		def can_move? move, otherPiece
			if otherPiece.color==@color
				return false
			end
			if move.cols.abs==2 && move.rows==1.abs
				return true
			elsif move.cols.abs == 1 && move.rows.abs == 2
				return true
			end
			false
		end

	end

	class Bishop < Piece
		CODE="B"
		def initialize color
			@color = color
		end
	end

	class Queen < Piece
		CODE="Q"
		def initialize color
			@color = color
		end
	end

	class King < Piece
		CODE="K"
		def initialize color
			@color = color
		end
	end

	class Move
		attr_accessor :from_row
		attr_accessor :from_col
		attr_accessor :to_row
		attr_accessor :to_col

		def initialize move
			letters = " abcdefgh"
			tokens = move.split
			@from_col = letters.index(tokens[0][0])
			@from_row = Integer(tokens[0][1])
			@to_col = letters.index(tokens[1][0])
			@to_row = Integer(tokens[1][1])
		end
		
		def rows
			@to_row - @from_row
		end

		def cols
			@to_col - @from_col
		end
	end

	class Board
		@pieces = Array.new {Array.new}
		def initialize lines
            @pieces = Array.new {Array.new}
			(1..8).each do |x|
				@pieces[x]=Array.new
			end

			line_number = 9
			lines.each_line do |line|
				line.chomp!
				next if line.empty?
				line_number -=1
				tokens = line.split
				token_number = 0
				tokens.each do |token|
					token_number += 1
					color = token[0]
					code = token[1]
					if code==Pawn::CODE
						@pieces[line_number][token_number] = Pawn.new color
					elsif code == Rook::CODE
						@pieces[line_number][token_number] = Rook.new color
					elsif code == Knight::CODE
						@pieces[line_number][token_number] = Knight.new color
					elsif code == Bishop::CODE
						@pieces[line_number][token_number] = Bishop.new color
					elsif code == Queen::CODE
						@pieces[line_number][token_number] = Queen.new color
					elsif code == King::CODE
						@pieces[line_number][token_number] = King.new color
					end
				end
			end
		end

		def legal_move? move
			piece = @pieces[move.from_row][move.from_col]
			otherPiece = @pieces[move.to_row][move.to_col]
			if(otherPiece != nil && piece.color == otherPiece.color)
				return "ILLEGAL"
			end
			can_move = piece.can_move? move, otherPiece
			can_move ? "LEGAL" : "ILLEGAL"
			
		end
	end
end