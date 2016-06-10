require 'sinatra'
require 'sinatra/reloader' if development?

configure do
	enable :sessions
end


get '/' do
	if session[:secret_code] == nil
		redirect to('/newgame')
	else
		if session[:history].length >= 12
			redirect to('/lose')
		else
			@history = session[:history]
			erb :main
		end
	end
end

post '/' do
	@message = evaluate_code(params[:guess])
	session[:history] << params[:guess]
	redirect to('/')
end


get '/win' do 
	@secret_code = session[:secret_code]
	erb :win
end

get '/newgame' do 
	session[:history] = []
	session[:secret_code] = set_code
	redirect to('/')
end

get '/lose' do 
	@secret_code = session[:secret_code]
	erb :lose
end

helpers do 
	def set_code
		@secret_code = []
		4.times {@secret_code.push((rand(5) + 1).to_s)}
		@secret_code
	end

	def evaluate_code(user_guess)
		guess_array = user_guess.scan(/./)
		puts session[:secret_code].to_s
		computer_response = []
		temp_code = session[:secret_code].clone
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
			puts computer_response.to_s
			computer_response		
		end
	end
end