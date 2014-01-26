module AdventureCapital
	class Names
		@@first_names = nil
		@@traits = nil

		def self.generate_name
			"#{first_name} the #{trait}"
		end

		def self.first_name
			load_first_names if !@@first_names
			random_word @@first_names
		end

		def self.trait
			load_traits if !@@traits
			random_word @@traits
		end

		private
		def self.load_first_names
			@@first_names = load_words "./lib/adventure_capital/assets/first_names.txt"
		end

		def self.load_traits
			@@traits = load_words "./lib/adventure_capital/assets/traits.txt"
		end

		def self.load_words filename
			File.readlines(filename).map{|n|n.chomp.strip}
		end

		def self.random_word words
			r = Random.new
			name_count = words.length

			words[r.rand(0..name_count-1)]	
		end
	end
end