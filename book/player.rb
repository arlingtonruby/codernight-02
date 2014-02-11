
###########################################
#
#  Jennifer Galvin
#  2/11/2014
#
############################################



load 'Coordinates.rb'
load 'ChessPiece.rb'
load 'ChessBoard.rb'

theChessBoard = ChessBoard.instance
theChessBoard.loadGame("complex_board.txt")

file = File.open("complex_moves.txt","r")
while (line = file.gets)
	mySplit = line.split(" ")
	myCoordinates = Coordinates.new(mySplit[0], mySplit[1])
	begin
		theChessBoard.playMove(myCoordinates)
		print "LEGAL\n"
		
	rescue
			print "ILLEGAL\n"
	end
end
file.close