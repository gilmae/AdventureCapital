include AdventureCapital

FactoryGirl.define do
	factory :goblin_fight, class: Challenge do
		targets {{:dps=>1}}
		damage 5
		level 1
	end

	factory :ogre_fight, class: Challenge do
		targets {{:dps=>5}}
    damage 4
    level 6
	end

	factory :cow_fight, class: Challenge do
		targets {{:dps=>1000}}
		damage 1 
		level 10
	end
end