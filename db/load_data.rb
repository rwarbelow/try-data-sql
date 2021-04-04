require 'sequel' 
require 'pg'
require 'csv'

db_string = "" # insert pg connection string here

db = URI.parse(db_string)
DB = Sequel.postgres(db.path[1..-1], :host => db.host, :port => db.port, :max_connections => 5, :user => db.user, password: db.password)

# DB.drop_table(:ramen, :tips, :goodreads, :trends)

DB.create_table :ramen do
  primary_key :review_id
  String :brand
  String :variety
  String :style
  String :country
  Float :stars
end

DB.create_table :tips do
  primary_key :id
  Float :total_bill
  Float :tip
  String :sex
  Integer :smoker
  String :day
  Integer :time
end

DB.create_table :goodreads do
  primary_key :id
  String :brand
  String :votes
  String :title
  String :category
  Integer :year
  Float :avg_rating
  String :authors
  Float :pages
  String :publisher
  Integer :rank
end

DB.create_table :trends do
  primary_key :id
  String :location
  Integer :year
  String :category
  Integer :rank
  String :query
end

# Load Trends data

trends = DB[:trends]
id = 1
CSV.foreach("trends.csv", headers: true, header_converters: :symbol) do |row|
  trends.insert(id: id, location: row[:location], year: row[:year], category: row[:category], rank: row[:rank], query: row[:query])
  id += 1
end

# Load Ramen data

ramen = DB[:ramen]

CSV.foreach("ramen-ratings.csv", headers: true, header_converters: :symbol) do |row|
  ramen.insert(review_id: row[:id], brand: row[:brand], variety: row[:variety], style: row[:style], country: row[:country], stars: row[:stars])
end

# Load Goodreads data

goodreads = DB[:goodreads]
id = 1
CSV.foreach("GoodReadsAwards.csv", headers: true, header_converters: :symbol) do |row|
  goodreads.insert(id: id, rank: row[:rank], votes: row[:votes], title: row[:title], category: row[:category], year: row[:year], avg_rating: row[:avg_rating], authors: row[:authors], pages: row[:pages], publisher: row[:publisher])
  id += 1
end

# Load Tips data
tips = DB[:tips]
id = 1
CSV.foreach("tips.csv", headers: true, header_converters: :symbol) do |row|
  tips.insert(id: id, total_bill: row[:total_bill], tip: row[:tip], sex: row[:sex], smoker: row[:smoker], day: row[:day], time: row[:time])
  id += 1
end
