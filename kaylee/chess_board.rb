require './chess_piece'

class ChessBoard

  def initialize
    @board = []
    @pieces = {}
  end

  def create_board(board_filename)    
    @count = 0
    @row = []
    File.open("inputs/#{board_filename}").each_line do |line|
      line.split(" ").each do |p|
        # p is name of piece
        
          @row << @pieces[p]
        
      end
      @board << @row
      @row = []
    end
  end

  def convert_move_to_x_y

  end

  def is_move_valid?(from_position, to_position)
    puts from_position + " to " + to_position
    from_position_xy = [("a"..from_position[0]).to_a.length-1,8 - from_position[1].to_i] 
    to_position_xy = [("a"..to_position[0]).to_a.length-1,8 - to_position[1].to_i] 

    #convert to a2 a3 to [x,y] move
    #a2 a3 = [0, 1], a2 b2 = [1, 1]
    xy_to_get_there = [(from_position[0]..to_position[0]).to_a.length-1,from_position[1].to_i - to_position[1].to_i]
    
    #number of pieces moves iterate on xy_to_get_there seeing if there are any pieces in the way, fail if so
    #unless their superman, superman can fly 
    #if it's the last iteration and there is a piece there, FIGHT!
    current_piece = @board[from_position_xy[1]][from_position_xy[0]]
    
    puts "from positon: " + from_position_xy.to_s
    puts "to positon: " + to_position_xy.to_s
    puts "xy to get there: " + xy_to_get_there.to_s
    puts "Current piece name: " + current_piece.name


    iterations = 0
    current_position = from_position_xy

    if can_piece_make_this_move?(from_position, to_position)
      # incrementer = [(from_position_xy[0] - to_position[0])/current_piece.valid_moves[0][0],]
      while(current_piece.num_moves > iterations)
        #while moving current_position incremented by available moves
        
        puts "Iteration Number: " + iterations.to_s
        
        current_position = [current_position[0] + xy_to_get_there[0], current_position[1] + xy_to_get_there[1]]
        
        puts "This position: " + current_position.to_s
        
        #If the position does not have a piece there, we're okay
        
        if @board[current_position[1]][current_position[0]].non_piece?# puts @board[current_position[1]][current_position[0]].name
          # puts "This is a valid move"
        else
          # puts "There is a piece there"
        end
        
        #add one move to position, is this the final position

        iterations += 1
      end
    else
      return false
    end
    if current_piece.num_moves == iterations  
      return true
    else
      return false
    end
  end

    def can_piece_make_this_move?(from_position, to_position)
    from_position_xy = [("a"..from_position[0]).to_a.length-1,8 - from_position[1].to_i] 
    to_position_xy = [("a"..to_position[0]).to_a.length-1,8 - to_position[1].to_i] 

    current_piece = @board[from_position_xy[1]][from_position_xy[0]]

    puts from_position_xy
    puts to_position_xy
    puts current_piece.name

    rise = from_position_xy[1] - to_position_xy[1]
    run = from_position_xy[0] - to_position_xy[0]
    puts (run).to_s + " / " + (rise).to_s

    if run > 2 || run < -2
      rise = rise / run.abs
      run = run / run.abs
    end

    puts (run).to_s + " / " + (rise).to_s
  end

  # def can_piece_make_this_move?(from_position, to_position)
  #   from_position_xy = [("a"..from_position[0]).to_a.length-1,8 - from_position[1].to_i] 
  #   to_position_xy = [("a"..to_position[0]).to_a.length-1,8 - to_position[1].to_i] 

  #   current_piece = @board[from_position_xy[1]][from_position_xy[0]]
  #   # puts current_piece.name
  #   current_piece.valid_moves.each do |m|
  #     # puts from_position_xy.to_s
  #     current_position = [from_position_xy[0] + m[0], from_position_xy[1] + m[1]]

  #     iterations = 0
  #     while(current_piece.num_moves > iterations)
  #       if current_position == to_position_xy
  #         # puts "BAM"
  #         return true
  #       end
  #       # puts "current position: " + current_position.to_s
  #       current_position = [current_position[0] + m[0], current_position[1] + m[1]]
        
  #       iterations += 1
  #     end
  #   end
  #   return false
  # end

  def create_pieces
    #rooks
    @pieces["bR"] = ChessPiece.new("bR", [[0,1], [1,0], [0,-1], [-1,0]], 7, false)
    @pieces["wR"] = ChessPiece.new("wR", [[0,1], [1,0], [0,-1], [-1,0]], 7, false)
    
    #knights
    @pieces["bN"] = ChessPiece.new("bN", [[2,1], [2,-1], [1,-2], [-1,-2], [-2,1], [-2,-1], [-1,2], [1,2]], 1, true)
    @pieces["wN"] = ChessPiece.new("wN", [[2,1], [2,-1], [1,-2], [-1,-2], [-2,1], [-2,-1], [-1,2], [1,2]], 1, true)
    
    #bishop
    @pieces["bB"] = ChessPiece.new("bB", [[1,1], [1,-1], [-1,-1], [-1,1]], 7, false)
    @pieces["wB"] = ChessPiece.new("wB", [[1,1], [1,-1], [-1,-1], [-1,1]], 7, false)

    #queen
    @pieces["bQ"] = ChessPiece.new("bQ", [[0,1], [1,0], [0,-1], [-1,0], [1,1], [1,-1], [-1,-1], [-1,1]], 7, false)
    @pieces["wQ"] = ChessPiece.new("wQ", [[0,1], [1,0], [0,-1], [-1,0], [1,1], [1,-1], [-1,-1], [-1,1]], 7, false)
    #king
    @pieces["bK"] = ChessPiece.new("bK", [[0,1], [1,0], [0,-1], [-1,0], [1,1], [1,-1], [-1,-1], [-1,1]], 1, false)
    @pieces["wK"] = ChessPiece.new("wK", [[0,1], [1,0], [0,-1], [-1,0], [1,1], [1,-1], [-1,-1], [-1,1]], 1, false)

    #pawn
    @pieces["bP"] = ChessPiece.new("bP", [[0,1]], 2, false)
    @pieces["wP"] = ChessPiece.new("wP", [[0,-1]], 2, false)

    #empty space
    @pieces["--"] = ChessPiece.new("--", [], 0, false)
    @pieces["-+"] = ChessPiece.new("-+", [], 0, false)
  end

  #Display methods
  def display_board
    count = 8
    puts "    a  b  c  d  e  f  g  h"
    puts "    0  1  2  3  4  5  6  7"
    @board.each do |b|
      print count.to_s + " " + (8-count).to_s + " "
      b.each do |sb|
        print sb.name + " "
      end
      puts
      count -= 1
    end  
  end

  def list_pieces
    puts @pieces
  end

end
