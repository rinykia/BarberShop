require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"     
end

get '/about' do
  @error = 'ERROR!'
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
  @colorpicker = params[:colorpicker]

  h = {:username => 'Type name', 
  	   :phone => 'Type phone', 
  	   :datetime => 'Type date and time'} 

  h.each do |k, v|
    if params[k] == ''
      @error = h[k]
      
      return erb :visit
    end
  end

  @title = 'Thank you!'
  @message = "Dear #{@username},I am #{@master}, I'll be waiting you at #{@datetime}, Color: #{@colorpicker}"
  f = File.open './public/users.txt', 'a'
  f.write "User: #{@username}, Phone: #{@phone}, Date and time: #{@datetime}, #{@master}, Color: #{@colorpicker}; "
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



