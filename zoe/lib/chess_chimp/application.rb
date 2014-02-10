module ChessChimp
  class UsageError < StandardError
    def message
      "USAGE: validate <boardfile> <movefile>"
    end
  end

  class Application

    def initialize(args)
      raise UsageError unless args.length == 2
      @game_state = ChessChimp::GameState.new(args[0])
      @move_list = ChessChimp::MoveList.new(args[1])      
    end

    def run
      results = @move_list.move_results(@game_state)
      results.each do |result|
        puts result
      end
    end
  end

end