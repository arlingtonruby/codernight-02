require_relative '../lib/chess_chimp/game_state'

describe 'ChessChimp::GameState' do

	let(:valid_filename) { 'xxx' }
	let(:lines) {
		[ "bK -- -- -- -- bB -- --\n", 
		  "-- -- -- -- -- bP -- --\n", 
		  "-- bP wR -- wB -- bN --\n", 
		  "wN -- bP bR -- -- -- wP\n", 
		  "-- -- -- -- wK wQ -- wP\n", 
		  "wR -- bB wN wP -- -- --\n", 
		  "-- wP bQ -- -- wP -- --\n", 
		  "-- -- -- -- -- wB -- --"]
	}

	let(:file_class_double) { double(:readlines => lines) }
	before(:each) do
    stub_const('File', file_class_double)
  end

	describe 'initialize' do
		it 'succeeds when given a valid file' do
			expect(ChessChimp::GameState.new(valid_filename)).to be_instance_of ChessChimp::GameState
		end
		it 'reads the file' do
			expect(File).to receive(:readlines).with(valid_filename).and_return(lines)
			ChessChimp::GameState.new(valid_filename)
		end

		it 'creates pieces' do 
			gs = ChessChimp::GameState.new(valid_filename)
			# This fails for unexplained reasons
			expect(::ChessChimp::Pieces::King).to receive(:new).with('b', 'a8')
		end
	end
end