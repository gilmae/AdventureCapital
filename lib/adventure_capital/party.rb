module AdventureCapital
	class Party < AdventurerBag
		attr_accessor :xp, :damage

		def initialize
			super 4
			@xp = 0
			@damage = 0
		end

		def ability type
			return nil if !Abilities::ALL_ABILITIES.include?(type)
			ratings = @members.map{|a| ((a.method(type).call) unless a.incapacitated?) || 0}
			ratings.inject(0){|sum,a| sum+=a}
		end

		def dps
			ability Abilities::DPS
		end

		def health
			ability(Abilities::HEALTH) - @damage
		end

		def exploration
			ability Abilities::EXPLORATION
		end

		def magic
			ability Abilities::MAGIC
		end

		def leadership
			ability Abilities::LEADERSHIP
		end

		def knowledge
			ability Abilities::KNOWLEDGE
		end

		def take_damage amount
    	@damage += amount

    	# Idea, when health - damage hits zero, randomly incapacitate a member and reset damage to 0
    	if health <= 0
    		candidates = @members.select{|m| !m.incapacitated?}

    		random_index = 1.d(candidates.length) - 1
    		candidates[random_index].incapacitate

    		@damage = 0
    	end
		end
	end
end