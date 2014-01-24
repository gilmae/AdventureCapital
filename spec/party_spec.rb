require File.dirname(__FILE__) + '/spec_helper'

include AdventureCapital

describe Party do
	it "has a property for the number of adventurers" do
    	party = FactoryGirl.build :party

    	expect(party.respond_to?('member_count')).to eq(true)
	    expect(party.member_count.class).to eq Fixnum
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

			expect(party.ability(:dps)).to eq 2
		end

		it "will return summed values of all member" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)
			party.recruit(FactoryGirl.build :cleric)

			expect(party.ability(:dps)).to eq 3
		end

		it "will return summed values of all members correct ability" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)
			party.recruit(FactoryGirl.build :mage)

			expect(party.ability(:dps)).to eq 2
			expect(party.ability(:magic)).to eq 4
		end
	end

	describe ".take_damage" do
		it "will reduce party health by amount of damage" do
			party = FactoryGirl.build :party
			party.recruit(FactoryGirl.build :fighter)

			expect(party.ability(:health)).to eq 5

			party.take_damage 2
			expect(party.ability(:health)).to eq 3
     
		end
	end
end