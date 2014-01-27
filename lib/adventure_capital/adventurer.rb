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

    def generate
      attributes = Abilities::ALL_ABILITIES

      current_tendencies = []
      current_tendencies << attributes
      6.times {

        attributes.each do |attribute|
          (method(attribute).call).times{current_tendencies << attribute}
        end

        current_tendencies.flatten!
        pick_and_increase_ability current_tendencies
      }

      @health+=1.d(3) - 1
      @name = Names.generate_name

      self
    end

    def upkeep
      level*50
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
    	current_tendencies = @tendencies || []
  		if current_tendencies == []
  			current_tendencies = Abilities::ALL_ABILITIES
  		end	

    	pick_and_increase_ability current_tendencies

    	@xp -= @level + 1
    	@level += 1
    end

    private
    def pick_and_increase_ability tendencies
      r = Random.new
      tendencies.flatten!
      index = r.rand(1..tendencies.length) - 1
      
      type = tendencies[index]
      
      value = method(type).call || 0

      method(type.to_s + '=').call(value+1)
    end
	end
end