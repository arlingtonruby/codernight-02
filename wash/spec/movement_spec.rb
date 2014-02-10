require 'movement'

describe Movement do
  it '::integer_to_char' do
    expect(Movement.integer_to_char 97).to eql 'a'
    expect(Movement.integer_to_char 98).to eql 'b'
    expect(Movement.integer_to_char 104).to eql 'h'
  end

  context '#intervening_squares_on_row_path' do
    describe 'w none' do
      before { @o = Movement.new('a2', 'a3') }
      it { expect(@o.intervening_squares_on_row_path).to be nil}
    end

    describe 'w one' do
      before { @o = Movement.new('a2', 'a4') }
      subject { @o.intervening_squares_on_row_path }
      it do
        expect(subject.length).to eql 1
        expect(subject[0]).to eql 'a3'
      end
    end

    describe 'w two' do
      before { @o = Movement.new('a2', 'a5') }
      subject { @o.intervening_squares_on_row_path }
      it do
        expect(subject.length).to eql 2
        expect(subject[0]).to eql 'a3'
        expect(subject[1]).to eql 'a4'
      end
    end
  end

  context '#intervening_squares_on_col_path' do
    describe 'w none' do
      before { @o = Movement.new('a2', 'b2') }
      it { expect(@o.intervening_squares_on_col_path).to be nil}
    end

    describe 'w one' do
      before { @o = Movement.new('a2', 'c2') }
      subject { @o.intervening_squares_on_col_path }
      it do
        expect(subject.length).to eql 1
        expect(subject[0]).to eql 'b2'
      end
    end

    describe 'w two' do
      before { @o = Movement.new('a2', 'd2') }
      subject { @o.intervening_squares_on_col_path }
      it do
        expect(subject.length).to eql 2
        expect(subject[0]).to eql 'b2'
        expect(subject[1]).to eql 'c2'
      end
    end
  end

  context 'w/o path obstructed' do
    before { @position = Position.new }
    describe '#white row distance 1' do
      before do
        @o = Movement.new('a2', 'a3')
        @o.should_receive(:path_obstructed?).at_least(:once) { nil }
      end
      it do
        expect(@o.row_or_col? @position).to be true
        expect(@o.diagonal?).to be false
        expect(@o.pawn_row? @position).to be true
        expect(@o.pawn_capture?).to be false
        expect(@o.knight?).to be false
      end
    end

    describe '#rook distance 2' do
      before do
        @o = Movement.new('a2', 'c2')
        @o.should_receive(:path_obstructed?).at_least(:once) { nil }
      end
      it do
        expect(@o.row_or_col? @position).to be true
        expect(@o.diagonal?).to be false
        expect(@o.pawn_row? @position).to be false
        expect(@o.pawn_capture?).to be false
        expect(@o.knight?).to be false
      end
    end

    describe '#bishop distance 2' do
      before do
        @o = Movement.new('a2', 'c4')
        @o.should_receive(:path_obstructed?).at_least(:once) { nil }
      end
      xit do
        expect(@o.row_or_col? @position).to be false
        expect(@o.diagonal?).to be true
        expect(@o.pawn_row? @position).to be false
        expect(@o.pawn_capture?).to be false
        expect(@o.knight?).to be false
      end
    end

    context '#knight' do
      describe 'w row distance 1' do
        before { @o = Movement.new('a2', 'c3') }
        it do
          expect(@o.row_or_col? @position).to be false
          expect(@o.diagonal?).to be false
          expect(@o.pawn_row? @position).to be false
          expect(@o.pawn_capture?).to be false
          expect(@o.knight?).to be true
        end
      end

      describe 'w row distance 2' do
        before { @o = Movement.new('a2', 'b4') }
        it do
          expect(@o.row_or_col? @position).to be false
          expect(@o.diagonal?).to be false
          expect(@o.pawn_row? @position).to be false
          expect(@o.pawn_capture?).to be false
          expect(@o.knight?).to be true
        end
      end
    end
  end
end
