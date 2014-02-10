require 'board'

describe Board do
  describe '#index_to_column_string' do
    before { @o = Board.new('simple_board.txt') }
    it do
      expect(@o.index_to_column_string 0).to eql 'a'
      expect(@o.index_to_column_string 1).to eql 'b'
      expect(@o.index_to_column_string 7).to eql 'h'
    end
  end
end
