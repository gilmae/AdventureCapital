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
			challenge = FactoryGirl.build :goblin_fight
	
			expect(challenge.encounter(party)).to eq true
		end
	
		it "is failed if party cannot overcome target" do
			challenge = FactoryGirl.build :cow_fight
	
			expect(challenge.encounter(party)).to eq false
		end	
	
		it "inflicts no damage if party overcomes target" do
			challenge = FactoryGirl.build :goblin_fight
	
			expect(challenge.encounter(party)).to eq true
			expect(party.ability(:health)).to eq 5
		end
	
		it "iinflicts damage if party cannot overcome target" do
			challenge = FactoryGirl.build :cow_fight
	
			expect(challenge.encounter(party)).to eq false
			expect(party.ability(:health)).to eq 4
		end	
	end
end