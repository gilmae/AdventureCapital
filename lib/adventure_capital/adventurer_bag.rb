module AdventureCapital
	class AdventurerBag
		@max_size
		attr_accessor :members

        def initialize max_size=nil
        	@members = []
        	@max_size = max_size
        end

		def member_count
			@members.count
		end

		def recruit adventurer
			return if @max_size && @members.count >= @max_size
			@members << adventurer if adventurer.class == Adventurer
		end
	end
end