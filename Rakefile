require 'rake'
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
  # file = File.read('nl_city_list')
  file = open("https://nomadlist.com/api/v2/list/cities").read
  data_hash = JSON.parse(file)
  city_count = data_hash['result'].length
  data_hash['result'].each do |city|
    city_name = city['info']['city']['name']
    country_name = city['info']['country']['name']
    # lat = city['info']['location']['latitude']
    # long = city['info']['location']['longitude']
    # if city_name.match('\s')
    # city_name.gsub!(/\s/,"_")
    # end
    puts "#{city_name}, #{country_name}"
  end
end

desc 'Get flickr images by city & date range'
task "fetch:flickr" do
  city_name = "vancouver"
  flickr_api_key = ""
  URL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{flickr_api_key}&tags=#{city_name}&format=json&nojsoncallback=1"
  flickr_data = JSON.parse(open(URL).read)
end

# make tables for images(w/ source col), more temps (low, mean)
# yearly temp data
# add search_count/hits column to the cities table
# complete seed script and seed all data from
# NL/Wikipedia.
# add a table for