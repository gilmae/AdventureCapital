module AdventureCapital

	class Game
		attr_accessor :adventurers

		def initialize
			@adventurers = []
		end

		def generate
			25.times {@adventurers<<Adventurer.new.generate}
			self
		end
	end
end