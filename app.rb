require 'sinatra'
require 'sinatra/reloader' if development?

before do 
	@secret_code = ["3","4","5","6"]
end
get '/' do
	erb :main
end

post '/' do
	#evaluate guess set the message and reload main
	@message = evaluate_code(params[:guess])
	erb :main
end

get '/win' do 
	erb :win
end

helpers do 
	# def set_code
	# 	@secret_code = []
	# 	4.times {@secret_code.push(rand(6))}
	# 	# puts @secret_code.to_s
	# end

	def evaluate_code(user_guess)
		guess_array = user_guess.scan(/./)
		puts guess_array.to_s
		computer_response = []
		temp_code = @secret_code.clone
		if temp_code == guess_array
			# @game_over = true
			redirect to('/win')
		else
			guess_array.each_with_index do |guess, index|
				 if guess == temp_code[index]
				 	computer_response.push("+")
				 	guess_array[index],temp_code[index] = " ","x"
				 end
			end
		 	guess_array.each_with_index do |guess, index|
				 if temp_code.include?(guess)
				 	computer_response.push("-")
				 	temp_code[temp_code.index(guess)] = "x"
				 end
			end
			computer_response		
		end
	end
end