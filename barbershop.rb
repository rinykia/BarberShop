require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'


def get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
  return db
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
  "Users"
	(
	  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
	  "username" TEXT,
	  "phone" TEXT,
	  "datetime" TEXT,
	  "master" TEXT,
	  "colorpicker" TEXT
	)'
end

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


db = get_db
  db.execute 'insert into
	Users
	(
	  username,
	  phone,
	  datetime,
	  master,
	  colorpicker
	)
	values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @master, @colorpicker]

  erb "Ok, username is #{@username}, #{@phone}, #{@datetime}, #{@master}, #{@colorpicker}"
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

get '/showusers' do
  db = get_db

  @results = db.execute 'select * from Users order by id desc'

  erb :showusers
end



