require File.dirname(__FILE__) + '/spec_helper'

include AdventureCapital

describe Party do
	describe ".member_count" do
		it "counts number of adventurers recruited" do
    	party = FactoryGirl.build :party

    	expect(party.member_count).to eq(0)

    	party.recruit Adventurer.new
    	expect(party.member_count).to eq(1)
		end
	end

	describe ".recruit" do
		it "adds recruits to the member count" do
			party = FactoryGirl.build :party
			expect(party.member_count).to eq 0

			alice = FactoryGirl.build :fighter
			party.recruit alice

			expect(party.member_count).to eq 1
		end

		it "won't add more recruits than the maximum size" do
			party = FactoryGirl.build :party

			party.recruit(FactoryGirl.build :fighter)
			party.recruit(FactoryGirl.build :mage)
			party.recruit(FactoryGirl.build :cleric)
			party.recruit(FactoryGirl.build :thief)

			expect(party.member_count).to eq 4

			party.recruit(FactoryGirl.build :ranger)
			
			expect(party.member_count).to eq 4
		end
	end

	describe ".rating" do
		it "will return value of only member" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)

			expect(party.dps).to eq 2
		end

		it "will exclude incapacitated members" do
			party = FactoryGirl.build :party
			fighter = FactoryGirl.build :fighter
			fighter.incapacitate

			party.recruit(fighter)

			expect(party.dps).to eq 0
		end

		it "will return summed values of all member" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)
			party.recruit(FactoryGirl.build :cleric)

			expect(party.dps).to eq 3
		end

		it "will return summed values of all members correct ability" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)
			party.recruit(FactoryGirl.build :mage)

			expect(party.dps).to eq 2
			expect(party.magic).to eq 4
		end
	end

	context "Abilities" do
		subject(:party) do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :overly_multi_classed)
			party
		end		
		
		describe ".dps" do
			it "should sum correct ability" do
				expect(party.dps).to eq 1
			end
		end

		describe ".health" do
			it "should sum correct ability" do
				expect(party.health).to eq 2
			end
		end

		describe ".exploration" do
			it "should sum correct ability" do
				expect(party.exploration).to eq 3
			end
		end

		describe ".leadership" do
			it "should sum correct ability" do
				expect(party.leadership).to eq 4
			end
		end

		describe ".knowledge" do
			it "should sum correct ability" do
				expect(party.knowledge).to eq 5
			end
		end

		describe ".magic" do
			it "should sum correct ability" do
				expect(party.magic).to eq 6
			end
		end
	end

	describe ".take_damage" do
		it "will reduce party health by amount of damage" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)

			expect(party.health).to eq 5

			party.take_damage 2
			expect(party.health).to eq 3
		end

		it "will incapacitate a member if damage equals or exceeds health" do
			party = FactoryGirl.build :party
			fighter = FactoryGirl.build :fighter
			party.recruit(fighter)

			expect(party.health).to eq 5

			party.take_damage 5

			expect(fighter.incapacitated?).to eq true
		end

		it "will reset damage to zero if damage equals or exceeds health" do
			party = FactoryGirl.build :party
			fighter = FactoryGirl.build :fighter
			party.recruit(fighter)

			expect(party.health).to eq 5

			party.take_damage 5

			expect(party.damage).to eq 0
		end
	end
end