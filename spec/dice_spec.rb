require File.dirname(__FILE__) + '/spec_helper'
	
describe "Dice" do
	describe ".d" do
		it "should return a random number between min and max" do
			actual = 1.d 7

			expect((1..7)).to cover actual
		end

		it "should be unbiased" do
			total = 0
			
			2000.times{
				total += 1.d 16
			}

			actual = total / 2000

			expect((8..9)).to cover actual
		end
	end

	describe ".d4" do
		it "should average at ~2.5" do
			total = 0
			
			2000.times{
				total += 1.d4
			}

			actual = total / 2000

			expect((2..3)).to cover actual
		end

	end

	describe ".d6" do
		it "should average at ~3.5" do
			total = 0
			
			2000.times{
				total += 1.d6
			}

			actual = total / 2000

			expect((3..4)).to cover actual
		end

	end

	describe ".d8" do
		it "should average at ~4.5" do
			total = 0
			
			2000.times{
				total += 1.d8
			}

			actual = total / 2000

			expect((4..5)).to cover actual
		end

	end

	describe ".d10" do
		it "should average at ~5.5" do
			total = 0
			
			2000.times{
				total += 1.d10
			}

			actual = total / 2000

			expect((4..6)).to cover actual
		end

	end

	describe ".d12" do
		it "should average at ~6.5" do
			total = 0
			
			2000.times{
				total += 1.d12
			}

			actual = total / 2000

			expect((5..6)).to cover actual

		end
	end

	describe ".d20" do
		it "should average at ~10.5" do
			total = 0
			
			2000.times{
				total += 1.d20
			}

			actual = total / 2000

			expect((10..11)).to cover actual

		end
	end
end
