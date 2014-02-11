###########################################
#
#  Jennifer Galvin
#  2/11/2014
#
############################################

class Coordinates


	def initialize(coord1,coord2)

		@beforeX = setXY(coord1[1])
		@beforeY = setXY(coord1[0])

		@afterX = setXY(coord2[1])
		@afterY = setXY(coord2[0])
	end

	def setXY(coord1)
		case coord1
		when 'a'
			return 0
		when 'b'
			return 1
		when 'c'
			return 2
		when 'd'
			return 3
		when 'e'
			return 4
		when 'f'
			return 5
		when 'g' 
			return 6
		when 'h'
			return 7
		when '1'
			return 7
		when '2'
			return 6
		when '3'
			return 5
		when '4'
			return 4
		when '5'
			return 3
		when '6'
			return 2
		when '7'
			return 1
		when '8'
			return 0
		end
			
	end

	def getBeforeX
		return @beforeX
	end

	def getBeforeY
		return @beforeY
	end

	def getAfterX
		return @afterX
	end

	def getAfterY
		return @afterY
	end


end
