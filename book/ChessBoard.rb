
require 'singleton'
#load 'Coordinates.rb'
#load 'ChessPiece.rb'

class ChessBoard
	include Singleton
	#include ChessPiece
	#include Coordinates


	def initialize
		newGame 
	end

	def playMove(moveCoords)
		_startingX = moveCoords.getBeforeX
		_startingY = moveCoords.getBeforeY

		_myPiece = ChessPiece.new(@@currentBoard[_startingX][_startingY])
		if _myPiece.validate(moveCoords)
			#updateboard(moveCoords,_myPiece) - dammit, this cost me an hour!
		else
			raise "Invalid move!" 
		end
	end

	def loadGame(fileName)
		@@currentBoard = Array.new

		file = File.open(fileName, "r")
		while (line = file.gets)
			@@currentBoard.push(line.split)
		end
		file.close
	end


	def newGame	

		@@totalMoves = 0
		@@numWhiteMoves = 0
		@@numBlackMoves = 0
		@@currentBoard = [	["bR","bN","bB","bK","bQ","bB","bN","bR"],
							["bP","bP","bP","bP","bP","bP","bP","bP"],
							["--","--","--","--","--","--","--","--"],
							["--","--","--","--","--","--","--","--"],
							["--","--","--","--","--","--","--","--"],
							["--","--","--","--","--","--","--","--"],
							["bP","bP","bP","bP","bP","bP","bP","bP"],
							["wR","wN","wB","wQ","wK","wB","wN","wR"]]
							

	end

	def saveGame(fileName)

		# Work on this
		File.open(fileName,'w') do |lineWriter|
			for i in 0..@@currentBoard.length
				lineWriter.puts @@currentBoard[i]
				lineWriter.puts "\n"
			end
		end
	end

	def printBoard

		print "totalMoves = #{@@totalMoves}\n"
		print "numWhiteMoves = #{@@numWhiteMoves}\n"
		print "numBlackMoves = #{@@numBlackMoves}\n"
		print "\n"

		for i in 0..@@currentBoard.length
			print @@currentBoard[i]
			print "\n"
		end
	end

	def updateboard(moveCoords, piece)

		# move piece
=begin
		_startingX = moveCoords.getBeginX
		_startingY = moveCoords.getBeginY
		_endingX = moveCoords.getEndingX
		_endingY = moveCoords.getEndingY


		@currentBoard[_startingX,_startingY] == "=="
		@currentBoard[_endingX,_endingY] == piece.getPieceMoniker

=end

		# Now Track the Moves
		if piece.getColor() == "white"
			@@numWhiteMoves += 1
		else
			@@numBlackMoves += 1
		end
		@@totalMoves += 1
	end

	def getPieceAt(myCoords)
		return @@currentBoard[myCoords.getBeforeX][myCoords.getBeforeY]
	end

	def getCapturePieceAt(myCoords)
		return @@currentBoard[myCoords.getAfterX][myCoords.getAfterY]
	end

	def getNumBlackMoves
		return @@numWhiteMoves
	end

	def getNumWhiteMoves
		return @@numWhiteMoves
	end

	def getTotalMoves
		return @@totalMoves
	end

end


