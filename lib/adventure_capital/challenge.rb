module AdventureCapital
	class Challenge
    attr_accessor :targets, :level, :damage

    def initialize
    	@targets = {}
    end

    def generate level
    	@level = level

    	abilities = Abilities::ALL_ABILITIES.clone
    	abilities.delete :health

    	create_target abilities

    	create_target(abilities) if 1.d4 <= 2

    	self
    end

		def encounter party
       success = true

       @targets.each{|k,v| success &= party.ability(k).d6 > v.d6}

       party.take_damage(@damage) unless success
       success
		end

		def xp
			# The reward should be proportional to the risk. The risk itself is the 
			# amount of damage failure will incur multiplied by the chance of 
			# failure. A Challenge that causes 100 damage but is failed only 1% of
			# the time should give limited reward. A Challenge that causes a large
			# percentage of a party's health in damage and is failed 50% of the time
			# should offer a large reward.

			difficulty = targets.map{|k,v| v}.max
			difficulty += targets.length - 1

			damage * difficulty/level
		end

		def create_target abilities
			ability = pick_challenge_type abilities
    	abilities.delete ability

    	targets[ability] = @level + 1.d4 - 2
    end

		def pick_challenge_type abilities
			index = 1.d(abilities.length) - 1

			abilities[index]
		end
	end
end