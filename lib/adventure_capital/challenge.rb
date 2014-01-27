module AdventureCapital
	class Challenge
    attr_accessor :targets, :damage

		def encounter party
       success = true

       @targets.each{|k,v| success &= roll(party.ability(k)) > v}

       party.take_damage(@damage) unless success
       success
		end

		def roll dice
			r = Random.new
			total = 0
			dice.times { total += r.rand(1..6)}
			total
		end
	end
end