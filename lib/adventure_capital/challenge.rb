module AdventureCapital
	class Challenge
    attr_accessor :targets, :damage

		def encounter party
       success = true

       @targets.each{|k,v| success &= party.ability(k).d6 > v}

       party.take_damage(@damage) unless success
       success
		end
	end
end