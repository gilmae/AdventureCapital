include AdventureCapital

FactoryGirl.define do
	factory :goblin_fight, class: Challenge do
		targets {{:dps=>1}}
		damage 5

	end

	factory :ogre_fight, class: Challenge do
		targets {{:dps=>5}}
    damage 4
	end

	factory :cow_fight, class: Challenge do
		targets {{:dps=>10}}
		damage 1 
	end
end