class ChessPiece

	def initialize(moniker)
		@pieceMoniker = moniker
		case moniker[0].downcase
			when 'w'
				@pieceColor = "white"
			when 'b'
				@pieceColor = "black"
			when '-'
				@pieceColor = nil
		end

			case moniker[1].downcase
				when 'r'
					@pieceName = "rook"
				when 'n'
					@pieceName = "knight"
				when 'b'
					@pieceName = "bishop"
				when 'q'
					@pieceName = "queen"
				when 'k'
					@pieceName = "king"
				when 'p'
					@pieceName = "pawn"
				when '-'
					@pieceName = "space"
			end

	end

	def getColor
		return @pieceColor
	end

	def getName
		return @pieceName
	end

	def getMoniker
		return @pieceMoniker
	end

	def validate(moveCoords)

		#No piece can land on another of it's own color piece, so let's check that first
		theChessboard = ChessBoard.instance
		_capturePiece = ChessPiece.new(theChessboard.getCapturePieceAt(moveCoords))
		if _capturePiece and _capturePiece.getColor == @pieceColor
			return false
		end 

		case @pieceName
			when "rook"
				return validateRook(moveCoords)
			when "bishop"
				return validateBishop(moveCoords)
			when "queen"
				return validateQueen(moveCoords)
			when "pawn"
				return validatePawn(moveCoords)
			when "king"
				return validateKing(moveCoords)
			when "knight"
				return validateKnight(moveCoords)
		end

	end

	def validateRook(moveCoords)

		# Construct valid moves array for this piece
		_startingX = moveCoords.getBeforeX
		_startingY = moveCoords.getBeforeY

		_endingX = moveCoords.getAfterX
		_endingY = moveCoords.getAfterY

		#Rooks move horizontally
		_validMoves = Array.new

		for i in 0..7
			_validMoves.push [i,startingY]
		end

		#And vertically
		for j in 0..7
			_validMoves.push [_startingX,j]
		end

		# Return if the after Coordinate is in the valid moves array
		_isAValidMove = false
		for i in 0.._validMoves.length
			if _validMoves[i] == [_endingX,_endingY]
				_isAValidMove = true
			end
		end

		return _isAValidMove

	end


	def validateKnight(moveCoords)

		# Construct valid moves array for this piece
		_startingX = moveCoords.getBeforeX
		_startingY = moveCoords.getBeforeY

		_endingX = moveCoords.getAfterX
		_endingY = moveCoords.getAfterY

		#Knights Move in L's, 2 squares first in any direction
		_validMoves = Array.new
		i = _startingX
		j = _startingY
		_validMoves.push([i-1,j-2])
		_validMoves.push([i-2,j-1])
		_validMoves.push([i-2,j+1])
		_validMoves.push([i-1,j+2])
		_validMoves.push([i+1,j+2])
		_validMoves.push([i+2,j+1])
		_validMoves.push([i+1,j-2])
		_validMoves.push([i+2,j-1])


		# Return if the after Coordinate is in the valid moves array
		_isAValidMove = false
		for i in 0.._validMoves.length
			if _validMoves[i] == [_endingX,_endingY]
				_isAValidMove = true
			end
		end

		return _isAValidMove

	end

	def validateBishop(moveCoords)

		# Construct valid moves array for this piece
		_startingX = moveCoords.getBeforeX
		_startingY = moveCoords.getBeforeY

		_endingX = moveCoords.getAfterX
		_endingY = moveCoords.getAfterY

		#Bishops move diagonally
		_validMoves = Array.new

		#Northwest
		i = _startingX
		j = _startingY
		while (i > 0 and j > 0)
			_validMoves.push [i -= 1,j -= 1]
			i -= 1
			j -= 1
		end

		# Southwest
		i = _startingX
		j = _startingY
		while (i > 0 and j > 0)
			_validMoves.push [i += 1,j -= 1]
		end

		#Northeast
		i = _startingX
		j = _startingY
		while (i > 0 and j > 0)
			_validMoves.push [i -= 1,j += 1]
		end

		#Southeast
		i = _startingX
		j = _startingY
		while (i < 8 and j <  8)
			_validMoves.push [i += 1,j += 1]
		end

		# Return if the after Coordinate is in the valid moves array
		_isAValidMove = false
		for i in 0.._validMoves.length
			if _validMoves[i] == [_endingX,_endingY]
				_isAValidMove = true
			end
		end

		return _isAValidMove
	end

	def validateQueen(moveCoords)
		
		#Queens can move in any one straight direction, like a rook or bishop
		_isAValidMove = Array.new
		_myResult = validateRook(moveCoords)
		_isAValidMove.push(_myResult)
		_myResult = validateBishop(moveCoords)
		return _isAValidMove.any? {true}
	end

	def validateKing(moveCoords)
		# Construct valid moves array for this piece
		_startingX = moveCoords.getBeforeX
		_startingY = moveCoords.getBeforeY

		_endingX = moveCoords.getAfterX
		_endingY = moveCoords.getAfterY

		#Kings move one space at a time
		_validMoves = Array.new

		i = _startingX - 1
		while i < (_startingX + 3)
			j = _startingY - 1
			while j < (_startingY + 3)
				_validMoves.push [i,j]
				j += 1
			end
			i += 1
		end

		#return _validMoves.any? { [_endingX,_endingY] }
		_isAValidMove = false
		for i in 0.._validMoves.length
			if _validMoves[i] == [_endingX,_endingY]
				_isAValidMove = true
			end
		end
		return _isAValidMove

	end

	def validatePawn(moveCoords)

		# Construct valid moves array for this piece
		_startingX = moveCoords.getBeforeX
		_startingY = moveCoords.getBeforeY

		_endingX = moveCoords.getAfterX
		_endingY = moveCoords.getAfterY

		#Pawns get away with the first move being 2 spaces towards the middle of the board
		if (@pieceColor == "white") and (_startingX -2 == _endingX) and (_endingY = _startingY) and (ChessBoard.instance.getNumWhiteMoves == 0)
			return true
		end

		if (@pieceColor == "black") and (_startingX +2 == _endingX) and (_endingY = _startingY) and (ChessBoard.instance.getNumBlackMoves == 0)
			return true
		end

		# Otherwise, pawns can only move forward and capture diagonally
		_validMoves = Array.new
		if @pieceColor == "white"
			i = _startingX - 1
		else
			i = _startingX + 1
		end
		_validMoves.push([i,_startingY])
		
		#Pawns can only move diagonally if they capture
		theChessboard = ChessBoard.instance
		_capturePiece = ChessPiece.new(theChessboard.getCapturePieceAt(moveCoords))
		if _capturePiece
			if ([i,_startingY - 1] == [_endingX,_endingY]) and (_capturePiece.getColor != @pieceColor)
				_validMoves.push([i,_startingY-1])
			end
			if ([i,_startingY - 1] == [_endingX,_endingY]) and (_capturePiece.getColor != @pieceColor)
				_validMoves.push([i,_startingY-1])
			end
		end
		
		_isAValidMove = false
		for i in 0.._validMoves.length
			if _validMoves[i] == [_endingX,_endingY]
				_isAValidMove = true
			end
		end
		return _isAValidMove




	end

end

	




