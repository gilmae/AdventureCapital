module AdventureCapital

	class Game
		attr_accessor :adventurers

		def initialize
			@adventurers = []
			@expeditions = []
		end

		def generate
			25.times {@adventurers<<Adventurer.new.generate}
			10.times {@expeditions << Expedition.new}
			self
		end
	end
end