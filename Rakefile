require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB << --- Needs to be changed for PG
desc "create the database"
task "db:create" do
  touch 'db/db.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/db.sqlite3'
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Seed City Data'
task "db:seed_cities_table" do
  # insert each city into db along with lat-long and country

end

desc 'Update City Data'
task "db:seed_cities_table" do
  # insert each city into db along with lat-long and country
  
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
    lat = city['info']['location']['latitude']
    long = city['info']['location']['longitude']
    # if city_name.match('\s')
    city_name.gsub!(/\s/,"_")
    # end
    puts "#{city_name} Lat: #{lat} Long:#{long}"
  end
end