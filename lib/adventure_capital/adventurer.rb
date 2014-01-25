module AdventureCapital
	class Adventurer
		attr_accessor :dps, :health, :exploration, :leadership, :knowledge, :magic, :name
    
    attr_reader :tendencies, :level, :xp

    def initialize
    	@dps = 0
    	@health = 0
    	@exploration = 0
    	@leadership = 0
    	@knowledge = 0
    	@magic = 0

    	@level = 1
    	@xp = 0
    end

    def give_xp xp
 			@xp += xp
    end

		def set_tendencies tendencies
			tendencies = [tendencies] if tendencies.class == Symbol

			@tendencies = tendencies
		end

		def can_level_up?
			@xp > @level
		end

    def level_up
      return unless can_level_up?
      r = Random.new
    	
    	current_tendencies = @tendencies || []
  		if current_tendencies == []
  			current_tendencies = [:dps, :health, :exploration, :leadership, :knowledge, :magic] 
  		end	

    	index = r.rand(1..current_tendencies.length) - 1
    	
    	type = current_tendencies[index]
      
      value = method(type).call || 0

    	method(type.to_s + '=').call(value+1)

    	@xp -= @level + 1
    	@level += 1
    end
	end
end