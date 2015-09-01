require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do 
  erb :index
end

get '/create' do
    @logfile = File.open("users.txt","r")
    erb :create
    @logfile.close
end

post '/' do
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]

  @title = 'Thank you!'
  @message = "Dear #{@user_name}, we'll be waiting for you at #{@date_time}"
  
  f = File.open './public/users.txt', 'a' #режим а apend, будем добавлять в конец файла(мак и линукс, создать заранее фаил и прописать chmod 777 users.txt)
  f.write "User: #{@user_name}, Phone: #{@phone}, Date and time: #{@date_time}"
  erb :message
end

get '/admin' do
  erb :admin
end

post '/admin' do
  @login = params[:login]
  @password = params[:password]
  if @login == 'admin' && @password == 'secret'
  	return erb :create
  elsif @login == 'admin' && @password == 'admin'
  	@message = 'Haha, nice try!Access denied!'
  	erb :index
  else 
  	@message = 'Access denied'
    erb :index
  end
end
get '/create' do
    @logfile = File.open("logfile.txt","r")
    erb :create
    @logfile.close
end
