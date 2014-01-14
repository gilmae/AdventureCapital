module AdventureCapital

	class Game
       attr_accessor :adventurers

       def initialize
       		@adventurers = []
       end

       def generate
          (1..20).each {a = Adventurer.new; a.generate; @adventurers << a}
       end

	end
end