require 'position'

describe Position do
  context '#piece_encoded_at' do
    before { @o = Position.new }
    describe 'w value' do
      before { @o['a'][1] = 'wK' }
      it { expect(@o.piece_encoded_at 'a1').to eql 'wK' }
    end

    it 'w/o value' do
      expect(@o.piece_encoded_at 'a2').to be nil
    end
  end
end
