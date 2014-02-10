require_relative '../../test_helper'
 
describe "Board" do
	before do
		simpleBoardText = File.open("test/data/simple_board.txt").read
		@simpleBoard = ChessValidator::Board.new simpleBoardText

		complexBoardText = File.open("test/data/complex_board.txt").read
		@complexBoardParser = ChessValidator::Board.new complexBoardText

		@simpleMovesText =  File.open("test/data/simple_moves.txt").read
		@simpleResultsText =  File.open("test/data/simple_results.txt").read
		
		@complexMovesText =  File.open("test/data/complex_moves.txt").read

	end


	it "should return the correct simplemove status" do

		results = @simpleResultsText.split(/\n/)
		counter = -1
		@simpleMovesText.each_line do |line|
			line.chomp!
			next if line.empty?
			counter+=1
			islegal = @simpleBoard.legal_move? ChessValidator::Move.new line

			assert results[counter]== islegal
		end
		
	end


	describe "Move" do
		it "give correct from/to col/row" do
			move = ChessValidator::Move.new "a2 c4"

			assert move.from_col == 1, "expected 1, was " << move.from_col
			assert move.from_row == 2, "expected 2, was " << move.from_row
			assert move.to_col == 3, "expected 3, was " << move.to_col
			assert move.to_row == 4 , "expected 4, was " << move.to_row
		end
	end
end