require_relative '../lib/chess_chimp/application'

describe 'ChessChimp::Application' do

  let(:valid_args) { ['boardfile', 'movefile'] }

  let(:gamestate_class) { double(:new => gamestate) }
  let(:gamestate) { double }

  let(:movelist_class) { double(:new => movelist) }
  let(:movelist) { double(:move_results => []) }

  before(:each) do
    stub_const('ChessChimp::GameState', gamestate_class)
    stub_const('ChessChimp::MoveList', movelist_class)
  end
  
  describe 'initialize' do
    it 'succeeds when given two file names' do
      expect(ChessChimp::Application.new(valid_args)).to be_instance_of ChessChimp::Application
    end

    it 'throws a usage error when given too many file names' do
      args = ['onefile', 'twofile', 'redfile', 'bluefile']
      expect {
        ChessChimp::Application.new(args)
      }.to raise_error(ChessChimp::UsageError)
    end

    it 'throws a usage error when given no file names' do
      args = []
      expect {
        ChessChimp::Application.new(args)
      }.to raise_error(ChessChimp::UsageError)
    end

    it 'creates a GameState from the board file' do
      expect(gamestate_class).to receive(:new).with('boardfile')
      ChessChimp::Application.new(valid_args)
    end

    it 'creates a MoveList from the move file' do
      expect(movelist_class).to receive(:new).with('movefile')
      ChessChimp::Application.new(valid_args)
    end
  end

  describe 'run' do
    let(:app) { ChessChimp::Application.new(valid_args) }

    it 'asks the move list for move results' do
      expect(movelist).to receive(:move_results).with(gamestate)
      app.run
    end
    it 'prints the move results' do
      results = ['the', 'results', 'here']
      allow(movelist).to receive(:move_results).and_return(results)
      results.each do |result|
        expect(app).to receive(:puts).with(result).ordered
      end
      app.run
    end
  end

end