module AdventureCapital
	class Adventurer
   		attr_accessor :dps, :health, :skills, :knowledge, :leadership
        @damage

        def initialize
        	@hdamage = 0
        end

   		def generate
           @dps = Random.rand(3)
           @health =  Random.rand(3)
           @skills =  Random.rand(3)
           @knowledge  = Random.rand(3) 
           @leadership = Random.rand(3)
   		end


	end
end