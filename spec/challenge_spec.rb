require File.dirname(__FILE__) + '/spec_helper'
	
include AdventureCapital

describe Challenge do	
	describe '.encounter'  do
		subject(:party) do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)
			party
		end
	
		it "is successful if party overcomes target" do
			party.recruit(FactoryGirl.build :superdps)
			challenge = FactoryGirl.build :goblin_fight
	
			expect(challenge.encounter(party)).to eq true
		end
	
		it "is failed if party cannot overcome target" do
			challenge = FactoryGirl.build :cow_fight
	
			expect(challenge.encounter(party)).to eq false
		end	
	
		it "inflicts no damage if party overcomes target" do
			challenge = FactoryGirl.build :goblin_fight
			party.recruit(FactoryGirl.build :superdps)

			expect(challenge.encounter(party)).to eq true
			expect(party.ability(:health)).to eq 5
		end
	
		it "inflicts damage if party cannot overcome target" do
			challenge = FactoryGirl.build :cow_fight
	
			expect(challenge.encounter(party)).to eq false
			expect(party.ability(:health)).to eq 4
		end	
	end

	describe ".xp" do
		it "has an xp reward" do
			challenge = FactoryGirl.build :cow_fight
			expect(challenge.xp).not_to be nil
		end

		it "has an xp reward based on damage and difficulty" do
			challenge = FactoryGirl.build :cow_fight
			challenge.level = 100

			expect(challenge.targets.length).to eq 1
			expect(challenge.targets[:dps]).to eq 1000
			expect(challenge.damage).to eq 1
			expect(challenge.xp).to eq 10
		end
	end
end