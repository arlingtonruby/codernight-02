require './chess_board'



this_board = ChessBoard.new()
this_board.create_pieces
this_board.create_board("simple_board.txt")

this_board.display_board
# this_board.list_pieces

input = ""
# while input.downcase != 'q' do
  puts "Please put enter your requested move. ex 'a2 a3':"
  # input = gets.chomp
  input = "d7 d6"
  split_input = input.split(" ")
  # puts "Valid Move: " + this_board.is_move_valid?(split_input[0], split_input[1]).to_s if input.downcase != 'q'
  puts this_board.can_piece_make_this_move?(split_input[0], split_input[1])
# end


input = "b7 c5"
split_input = input.split(" ")
puts this_board.can_piece_make_this_move?(split_input[0], split_input[1])

input = "c8 h3"
split_input = input.split(" ")
puts this_board.can_piece_make_this_move?(split_input[0], split_input[1])