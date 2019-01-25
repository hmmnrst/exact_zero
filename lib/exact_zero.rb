class Numeric
	##
	# Returns true when +self+ is exactly zero.
	#
	# @example
	#   (0/1r).exact_zero?   #=> true
	#   (-0.0).exact_zero?   #=> false
	#
	def exact_zero?
		zero? && 1.0 / (-abs2).to_f > 0
	end
end
