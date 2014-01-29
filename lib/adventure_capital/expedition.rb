module AdventureCapital
	class Expedition
		attr_reader :challenges
		
		def initialize
			@challenges = []
		end

		def generate level
			level.d4.times { @challenges << Challenge.new.generate(level) }

			self
		end

		def defend_against party
			@challenges.each do |challenge|
				challenge.encounter party
			end
		end
	end
end