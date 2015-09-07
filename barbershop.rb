require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


require 'sqlite3'

db = SQLite3::Database.new 'users.sqlite'

db.execute "SELECT * FROM Users" do |x|
	puts x
	puts "===="
end

db.close

db1 = SQLite3::Database.new 'contacts.sqlite'

db1.execute "SELECT * FROM Contacts" do |x|
	puts x
	puts "===="
end

db1.close
#
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

  @error = h.select {|k,_| params[k] == ""}.values.join(", ")
  if @error != ''
  	return erb :visit
  end

  @title = 'Thank you!'
  @message = "Dear #{@username},#{@master}, will waiting you at #{@datetime},(Color: #{@colorpicker})"
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

   h1 = {:email => 'Type email', 
  	   :message => 'Type message'} 

  @error = h1.select {|k,_| params[k] == ""}.values.join(", ")
  if @error != ''
  	return erb :contacts
  end
 
  a = File.open './public/contacts.txt', 'a'
  a.write "Email: #{@email}, message: #{@message}"
  a.close

  @title = 'Thank you!'
  @message = "Your message will be sending, we answer for you email: #{@email}"
  erb :message
end



