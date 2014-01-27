require File.dirname(__FILE__) + '/spec_helper'
	
include AdventureCapital

describe Game do
	describe ".generate" do
		subject(:game) {Game.new.generate}
		it "generates adventurers" do
			expect(game.adventurers.length).to be > 0
		end

		it "generates generated adventurers" do
			game.adventurers.each do |adventurer|
				expect(adventurer.name).not_to be nil
				sum = [adventurer.dps, adventurer.health, adventurer.leadership, adventurer.knowledge, adventurer.exploration, adventurer.magic].inject(0){|aggregate, value|aggregate+=value}

				expect(6..8).to cover sum
			end
		end
	end
end