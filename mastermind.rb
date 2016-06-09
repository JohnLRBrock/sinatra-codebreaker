class MasterMind
	def initialize
		@game_over = false
		set_code
	end

	def set_code
		@secret_code = []
		4.times {@secret_code.push(rand(6))}
		# puts @secret_code.to_s
	end

	def evaluate_code(user_guess)
		guess_array = user_guess.scan(/./)
		@computer_response = []
		temp_code = @secret_code.dup
		if temp_code == guess_array
			# puts "Congratulations!"
			# puts "You have successfully guessed the secret code"
			@game_over = true
		else
			guess_array.each_with_index do |guess, index|
				 if guess == temp_code[index]
				 	@computer_response.push("+")
				 	guess_array[index],temp_code[index] = " ","x"
				 end
			end

		 	guess_array.each_with_index do |guess, index|
				 if temp_code.include?(guess)
				 	@computer_response.push("-")
				 	temp_code[temp_code.index(guess)] = "x"
				 end
			end
			@computer_response			
		end
	end
end

