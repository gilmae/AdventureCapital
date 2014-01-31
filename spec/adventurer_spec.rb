require File.dirname(__FILE__) + '/spec_helper'
	
include AdventureCapital

describe Adventurer do	
	describe ".new" do
		subject(:adventurer) {Adventurer.new}
		
		it "sets abilities to zero" do
			expect(adventurer.dps).to eq 0
			expect(adventurer.health).to eq 0
			expect(adventurer.leadership).to eq 0
			expect(adventurer.exploration).to eq 0
			expect(adventurer.knowledge).to eq 0
			expect(adventurer.magic).to eq 0
		end
	
		it "sets level to one" do
			expect(adventurer.level).to eq 1
		end
	end

	describe ".generate" do
		subject(:adventurer) { Adventurer.new.generate }
		it "generates a name" do
			expect(adventurer.name).not_to be_nil
			expect(adventurer.name).not_to eq ""
		end

		it "generates abilities" do
			sum = [adventurer.dps, adventurer.health, adventurer.leadership, adventurer.knowledge, adventurer.exploration, adventurer.magic].inject(0){|aggregate, value|aggregate+=value}

			expect(6..8).to cover sum
			
		end
	end

	describe ".upkeep" do
		subject(:adventurer) { Adventurer.new.generate }
		
		it "increases by level" do
			old_upkeep = adventurer.upkeep

			adventurer.give_xp 10
			adventurer.level_up

			new_upkeep = adventurer.upkeep

			expect(old_upkeep).to be < new_upkeep
		end
	end

	describe ".incapacitate" do
		subject(:adventurer) { Adventurer.new.generate }

		it "incapacitates the adventurer" do
			expect(adventurer.incapacitated?).to eq false

			adventurer.incapacitate			

			expect(adventurer.incapacitated?).to eq true
		end
	end
	
	describe ".set_tendencies" do 
		it "accepts single symbols" do
			a = Adventurer.new
			a.set_tendencies :dps
	
			expect(a.tendencies).to eq [:dps]
		end
	
		it "accepts arrays of symbols" do
			a = Adventurer.new
			a.set_tendencies [:dps, :health]
	
			expect(a.tendencies).to eq [:dps, :health]
		end
	end
	
	describe ".can_level_up?" do
		subject(:adventurer) { Adventurer.new }
	
		it "false if xp is less than level" do
			expect(adventurer.xp).to be < adventurer.level
			expect(adventurer.can_level_up?).to eq false
		end
		
		it "false if xp is equal to level" do
			adventurer.give_xp adventurer.level
			expect(adventurer.xp).to eq adventurer.level
			expect(adventurer.can_level_up?).to eq false
		end
	
		it "true if xp is greater than level" do
			adventurer.give_xp (adventurer.level + 1)
			expect(adventurer.xp).to be > adventurer.level
			expect(adventurer.can_level_up?).to eq true
		end
	end
	
	describe ".level_up" do
		subject(:adventurer) do 
			adventurer = Adventurer.new
			adventurer.set_tendencies :dps
			adventurer.give_xp  2
			adventurer
		end
	
	  it "does not alter the adventurer if the adventurer can't level up" do
			adventurer = Adventurer.new
			adventurer.level_up
	
			abilities = [adventurer.dps, adventurer.health, adventurer.leadership, adventurer.knowledge, adventurer.exploration, adventurer.magic].sort
	
			expect(adventurer.level).to eq 1
			expect(abilities).to eq [0,0,0,0,0,0]
	    
	  end
	
		it "increases an ability from the tendencies" do
			adventurer.level_up
	
			expect(adventurer.dps).to eq 1
			expect(adventurer.health).to eq 0
			expect(adventurer.leadership).to eq 0
			expect(adventurer.exploration).to eq 0
			expect(adventurer.knowledge).to eq 0
			expect(adventurer.magic).to eq 0
	
		end
	
		it "increments the adventurer's level" do
			expect(adventurer.level).to eq 1
	
			adventurer.level_up
	
			expect(adventurer.level).to eq 2
		end

		it "deducts XP equal to the new level" do
			expected = adventurer.xp - (adventurer.level+1)
			
			adventurer.level_up

			expect(adventurer.xp).to eq expected
		end
	
		context "when no tendencies are defined" do
	
			it "picks from all abilities" do
				adventurer.set_tendencies []
	
				adventurer.level_up
	
				abilities = [adventurer.dps, adventurer.health, adventurer.leadership, adventurer.knowledge, adventurer.exploration, adventurer.magic].sort
	
				expect(abilities).to eq [0,0,0,0,0,1]
			end
	
			it "leaves tendencies empty afterwards" do
				adventurer.set_tendencies []
	
				adventurer.level_up
	
				expect(adventurer.tendencies).to eq []
			end
		end
	end
end