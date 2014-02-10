
def load_board_position
	sp_file = File.new("simple_board.txt", "r")
	board = sp_file.each_line.map(&:split)

	sp_file.close 

	@game ={}
	(1..8).to_a.reverse.each_with_index do |rank,i|
		("a".."h").each_with_index do |d,j|
			@game["#{d}#{rank}"] = "#{board[i][j]}"
		end
	end

end

def load_moves_and_check_moves

	sm_file = File.new("simple_moves.txt", "r")
	moves = sm_file.each_line.map(&:split)

	sm_file.close

	moves.each do |key, value|
		check_each_move(key, value)
	end
end

def check_each_move(move_from, move_to)
	piece_name = @game[move_from]
	
	puts case piece_name[1,1]
		when "P"
			move_result_for_pawn(piece_name, move_from, move_to)
		when "N" 
			move_result_for_knight(piece_name, move_from, move_to)
		when "Q" 
			"Call Queen's move"
		when "K" 
			"Call King's move"	
		when "B" 
			"Call Bishop's move"
		when "R" 
			"Call Rook's move"		
		when "-"
			"#{piece_name} empty square ILLEGAL"
		else
			"#{piece_name} ILLEGAL"
	end

end

def move_result_for_knight(piece_name, move_from, move_to)
	from_position = move_from[1,1].to_i
	to_position = move_to[1,1].to_i
	original_column = move_from[0,1].ord.to_i
	move_to_column  = move_to[0,1]
	allow_col = [(original_column+1).chr, (original_column-1).chr]
	
	case piece_name[0,1]
		when "w"
			move_steps = to_position - from_position
		when "b"
			move_steps = from_position - to_position
		else
			 "Unknow color!"
	end	

	if move_steps == 2 && allow_col.include?(move_to_column)
	 	"#{piece_name} wants to move from #{move_from} to #{move_to} - LEGAL"
	else
		"#{piece_name} wants to move from #{move_from} to #{move_to} - ILLEGAL"
	end
end

def move_result_for_pawn(piece_name, move_from, move_to)
	move_steps = move_to[1,1].to_i - move_from[1,1].to_i

	case piece_name[0,1]
		when "w"
			 move_steps = move_to[1,1].to_i - move_from[1,1].to_i
		when "b"
			 move_steps = move_from[1,1].to_i - move_to[1,1].to_i
		else
			 "Unknow color!"
	end	

	move_col = move_to[0,1] == move_from[0.1] ? true : false 
	if move_steps <= 2 && move_col
		"#{piece_name} wants to move from #{move_from} to #{move_to} - LEGAL"
	else
		"#{piece_name} wants to move from #{move_from} to #{move_to} - ILLEGAL"
	end

end

load_board_position
load_moves_and_check_moves

