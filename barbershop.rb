require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"     
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @master = params[:master]

  @title = 'Thank you!'
  @message = "Dear #{@username},I am #{@master}, I'll be waiting you at #{@datetime}"
  f = File.open './public/users.txt', 'a'
  f.write "User: #{@username}, Phone: #{@phone}, Date and time: #{@datetime}, #{@master}"
  f.close
  erb :message
end

get '/message' do
	erb :message
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message]

	a = File.open './public/contacts.txt', 'a'
	a.write "Email: #{@email}, message: #{@message}"
	a.close

	@title = 'Thank you!'
    @message = "Your message will be sending, we answer for you email: #{@email}"
    erb :message
end




