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
      attributes = base_tendencies

      current_tendencies = []
      current_tendencies << attributes
      (1..6).each {

        attributes.each do |attribute|
          (1..method(attribute).call).each{current_tendencies << attribute}
          current_tendencies.flatten!
        end
        pick_and_increase_ability current_tendencies
      }

      @health+=Random.new.rand(0..2)
      @name = Names.generate_name

      self
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
  			current_tendencies = base_tendencies
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

    def base_tendencies
      [:dps, :health, :exploration, :leadership, :knowledge, :magic] 
    end
	end
end