include AdventureCapital

FactoryGirl.define do
	factory :fighter, class: Adventurer do
		name 'fighter'
		dps 2
		health 5
	end

	factory :mage, class: Adventurer do
		name 'mage'
    magic 4
	end

	factory :cleric, class: Adventurer do
		name 'cleric'
		dps 1
	end

	factory :thief, class: Adventurer do
		name 'thief'
	end

	factory :ranger, class: Adventurer do
		name 'ranger'
	end

	factory :superdps, class: Adventurer do
		name 'SuperDPS'
		dps 20
	end
end