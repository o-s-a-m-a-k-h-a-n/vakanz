require 'rake'
require 'dotenv/tasks'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB <- changed to Postgres. Needs to be reviewed by TA
desc "create the database"
task "db:create" do
  # touch 'db/db.sqlite3'
  conn = PG.connect(dbname:'postgres')
  puts "Database 'app_vakanz' created successfully" if conn.exec('CREATE DATABASE app_vakanz')
end

desc "drop the database"
task "db:drop" do
  # rm_f 'db/db.sqlite3'
  conn = PG.connect(dbname:'postgres')
  puts "Database 'app_vakanz' created successfully" if conn.exec('DROP DATABASE app_vakanz')
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end


desc 'Retrieves (scrapes) Weather Data from Wikipedia City pages and store in DB'
task "fetch:weather" do
  file = open("https://nomadlist.com/api/v2/list/cities").read
  data_hash = JSON.parse(file)
  no_data_counter = 0
  index = 0
  no_data = Array.new
  data_hash['result'].each do |city|
    puts "---------------------------------"
    puts
    city_name = city['info']['city']['name']
    if city_name == 'Kinosaki-Onsen'
      next
    end
    if city_name == 'Krivoy-Rog'
      city_name = 'Kryvyi Rih'
    end
    city_name.gsub!(/\s/,"_")
    puts city_name
    doc = Nokogiri::HTML(open(URI.encode("https://en.wikipedia.org/wiki/#{city_name}")))
    response = doc.css("div#mw-content-text > table.wikitable.collapsible > tr")[1]
    puts doc.css("div#mw-content-text > table.wikitable.collapsible > tr")[1]
    unless response.is_a?(Nokogiri::XML::Element)
      no_data_counter += 1
      no_data << city_name
    end
    index+=1
    puts
    puts "Current city: #{index}"
    puts "Cities with no data: #{no_data_counter}"
  end

  # doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Vancouver"))
  # puts doc.css("div#mw-content-text > table.wikitable.collapsible > tr")[0] # ... > table)[1]
end

desc 'Fetch City List and save to file'
task "fetch:city_list" do
  puts "Loading city list"

  file = open("https://nomadlist.com/api/v2/list/cities").read
  data_hash = JSON.parse(file)
  
  data_hash['result'].each_with_index do |city, index|
    
    name = city['info']['city']['name']
    latitude = city['info']['location']['latitude']
    longitude = city['info']['location']['longitude']
    country = city['info']['country']['name']
    region = city['info']['region']['name']
    internet_download_speed = city['info']['internet']['speed']['download']
    wiki_slug = name.gsub(/\s/,"_")
    flickr_tag = name.gsub(/\s/,"%20")
    airbnb_median = city['cost']['airbnb_median']['USD']
    airbnb_vs_apartment_price_ratio = city['cost']['airbnb_vs_apartment_price_ratio']
    beer_in_cafe = city['cost']['beer_in_cafe']['USD']
    coffee_in_cafe = city['cost']['coffee_in_cafe']['USD']
    hotel = city['cost']['hotel']['USD']
    non_alcoholic_drink_in_cafe = city['cost']['non_alcoholic_drink_in_cafe']['USD']
    puts "\n#{index}: #{name}, #{country} (#{region}) - Lat: #{latitude} Long:#{longitude} DL: #{internet_download_speed} Wiki:#{wiki_slug} Flickr:#{flickr_tag} Airbnb: #{airbnb_median} (#{airbnb_vs_apartment_price_ratio}) Beer:#{beer_in_cafe} Coffee:#{coffee_in_cafe} Hotel:#{hotel} Coke:#{non_alcoholic_drink_in_cafe}"

  end
end

desc 'Get flickr images by city & date range'
task "fetch:flickr" do
  json_feed = open("https://nomadlist.com/api/v2/list/cities").read
  city_hash = JSON.parse(json_feed)
  
  city_hash['result'].each do |city|
    
    city_name = city['info']['city']['name'].downcase  
    city_name.gsub!(/\s/,"%20")
    
    city_name = "krakow" if city_name == "kraków"
    city_name = "wroclaw" if city_name == "wrocław"
    next if city_name.match(/medell[a-z]*/)
    
    flickr_api_key = ENV['FLICKR_AUTH_KEY']
    
    link = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{flickr_api_key}&tags=#{city_name}&format=json&nojsoncallback=1"
    
    flickr_data_for_city = JSON.parse(open(link).read)
    puts flickr_data_for_city['photos']['photo'].count
  end
end

# make tables for images(w/ source col), more temps (low, mean)
# yearly temp data
# complete seed script and seed all data from
# NL/Wikipedia.