module AdventureCapital

	class Party < AdventurerBag

		def initialize
			super 4
			@buffs = {}
			@buffs.default = 0
		end

		def ability type
			sum = 0
			ratings = @members.map{|a| (a.method(type).call) || 0}
			ratings.inject{|sum,a| sum+=a} + @buffs[type]
		end

		def take_damage amount
    	@buffs[:health] -= amount   
		end
	end
end
