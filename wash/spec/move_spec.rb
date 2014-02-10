require 'move'

describe Move do
  describe '#piece_to_move?' do
    before do
      @position = Position.new
      @position.should_receive(:piece_encoded_at).with('a2') { 'bQ' }
      @o = Move.new(@position, 'a2', 'a3')
    end
    it { expect(@o.piece_encoded_to_move?).to eql 'bQ' }
  end

  context '#valid?' do
    before { @position = Position.new }
    context 'white pawn' do
      before do
        @position.should_receive(:piece_encoded_at).with('a2').at_least(:once) { 'wP' }
        @position.should_receive(:piece_encoded_at).with('a3') { nil }
      end
      describe 'w valid movement' do
        before { @o = Move.new(@position, 'a2', 'a3') }
        it { expect(@o.valid?).to be true }
      end
    end
  end
end
