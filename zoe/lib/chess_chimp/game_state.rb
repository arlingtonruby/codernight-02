require_relative 'pieces'

module ChessChimp
	class GameState
		def initialize(filename)
			lines = File.readlines(filename)
      lines.each_with_index do |line, rank_index|
        rank = 8-rank_index
        squares = line.chomp.split(' ')
        file_letters = 'abcdefgh'
        squares.each_with_index do |square, file_index|
          file_letter = file_letters[file_index]
          create_piece(square, rank, file_letter)
        end
      end
		end

    def create_piece(square, rank, file_letter)
      square_location = "#{file_letter}#{rank}"
      piece_class = piece_class(square[1])
      p piece_class, square[0], square_location
      return piece_class.new(square[0], square_location)
    end

    def piece_class(letter)
      case letter
      when 'K' 
        ChessChimp::Pieces::King
      else 
        ChessChimp::Pieces::Empty
      end
    end
	end
end