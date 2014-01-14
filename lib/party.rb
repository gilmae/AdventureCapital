module AdventureCapital

	class Party
		@adventurers

		def initialize
			@adventurers = []
		end

		def recruit adventurer
			@adventurers << adventurer if adventurer.class == Adventurer
		end

		def challenge type
           @adventurers.map{|a| a.method(type).call}.max
		end
	end

end
