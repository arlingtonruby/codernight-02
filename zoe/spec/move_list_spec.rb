require_relative '../lib/chess_chimp/move_list'

describe 'ChessChimp::MoveList' do

	let(:valid_filename) { 'xxx' }
	let(:lines) {
		[ "a2 a3\n", 
		  "a2 a4\n"]
	}

	let(:file_class_double) { double(:readlines => lines) }
	before(:each) do
    stub_const('File', file_class_double)
  end

	describe 'initialize' do
		it 'succeeds when given a valid file' do
			expect(ChessChimp::MoveList.new(valid_filename)).to be_instance_of ChessChimp::MoveList
		end
		it 'reads the file' do
			expect(File).to receive(:readlines).with(valid_filename).and_return(lines)
			ChessChimp::MoveList.new(valid_filename)
		end
	end

end