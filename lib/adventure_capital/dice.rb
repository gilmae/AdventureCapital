class Fixnum
	def d type
		r = Random.new
		self.times.inject(0){|agg, val| agg += r.rand(1..type)}
	end

	def d4
		d 4
	end

	def d6
		d 6
	end

	def d8
		d 8
	end

	def d10
		d 10
	end

	def d12
		d 12
	end

	def d20
		d 20
	end
end