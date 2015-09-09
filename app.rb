#encoding: UTF-8
require  'sqlite3'

db = SQLite3::Database.new 'barbershop.db'
db.results_as_hash = true
db.execute 'select * from Users' do |row|
  #puts "#{row[1]} запись на #{row[3]}"
  print row['username']
  print "\t-\t"
  puts row['datetime']
  puts'================================='
end