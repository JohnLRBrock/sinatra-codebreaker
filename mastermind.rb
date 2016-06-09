class MasterMind
	def initialize
		@game_over = false
		user_play_game
		# computer_play_game
	end

	def set_code
		@secret_code = []
		4.times {@secret_code.push(rand(6))}
		# puts @secret_code.to_s
	end

	def guess_code
		puts
		puts "enter a 4 digit guess"
		puts "you have #{@user_turns_remaining} turns remaining"
		@user_guess = user_input_to_array
		puts @user_guess.to_s
	end
	def user_input_to_array
		@array = []
		user_input = gets.chomp
		if user_input.length == 4
			user_input.each_char { |char| @array.push(char.to_i)}
			@array
		else
			puts "that's not a valid entry"
			user_input_to_array
		end
	end
	def compare_codes(guess_array)
		@computer_response = []
		temp_code = @secret_code.dup
		if temp_code == guess_array
			puts "Congratulations!"
			puts "You have successfully guessed the secret code"
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
			puts @computer_response.join(" ")
			
		end
	end

	def user_play_game
		set_code
		@user_turns_remaining = 12
		system "clear"
		puts "Lets play MasterMind... try to guess the secret code!"
		puts
		puts "The secret code only contains the digits 0-5"
		puts
		puts "A '+' signifies a correct digit."  
		puts "A '-' signifies a correct digit that has been placed incorrectly"
		until @game_over do 
			guess_code	
			compare_codes(@user_guess)
			@user_turns_remaining -= 1
			@game_over = true if @user_turns_remaining == 0
		end
		puts "You ran out of turns!" if  @user_turns_remaining == 0
		puts "the secret code was #{@secret_code.to_s}"
		puts "Game Over"
	end
	def computer_play_game
		@user_turns_remaining = 12
		puts "PICK A 4-digit SECRET CODE"
		@secret_code = user_input_to_array
		puts @secret_code.to_s
		puts "OK I'VE GOT THIS"
		until @game_over do
			@computer_guess = []
			4.times {@computer_guess.push(rand(6))}
			puts @computer_guess.to_s
			compare_codes(@computer_guess)
			@user_turns_remaining -= 1
			@game_over = true if @user_turns_remaining == 0
		end
	end
end

game = MasterMind.new
