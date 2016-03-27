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
  puts "Database 'app_vakanz' CREATED successfully" if conn.exec('CREATE DATABASE app_vakanz')
end

desc "drop the database"
task "db:drop" do
  # rm_f 'db/db.sqlite3'
  conn = PG.connect(dbname:'postgres')
  puts "Database 'app_vakanz' DROPPED successfully" if conn.exec('DROP DATABASE app_vakanz')
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
  # make tables for images(w/ source col), more temps (low, mean)
  # yearly temp data
  # doc = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Vancouver"))
  # puts doc.css("div#mw-content-text > table.wikitable.collapsible > tr")[0] # ... > table)[1]
end

desc 'Fetch Nomad List data and store to database if empty'
task "fetch:nomad_list" do
  if City.count == 0
    nomad_list_json_feed = open("https://nomadlist.com/api/v2/list/cities").read
    data_hash = JSON.parse(nomad_list_json_feed)
    
    data_hash['result'].each_with_index do |city, index|
      
      name = city['info']['city']['name']
      
      if name == "kraków"
        name = "krakow"
      elsif name == "wrocław" 
        name = "wroclaw"
      elsif name.match(/medell[a-z]*/)
        name = "medellin"
      end

      latitude = city['info']['location']['latitude']
      longitude = city['info']['location']['longitude']
      country = city['info']['country']['name']
      region = city['info']['region']['name']
      internet_download_speed = city['info']['internet']['speed']['download']
      wiki_slug = name.gsub(/\s/,"_")
      flickr_tag = name.gsub(/\s/,"+")
      airbnb_median = city['cost']['airbnb_median']['USD']
      airbnb_vs_apartment_price_ratio = city['cost']['airbnb_vs_apartment_price_ratio']
      beer_in_cafe = city['cost']['beer_in_cafe']['USD']
      coffee_in_cafe = city['cost']['coffee_in_cafe']['USD']
      hotel = city['cost']['hotel']['USD']
      non_alcoholic_drink_in_cafe = city['cost']['non_alcoholic_drink_in_cafe']['USD']
      px250 = "https://nomadlist.com"+city['media']['image']['250']
      px500 = "https://nomadlist.com"+city['media']['image']['500']
      px1000 = "https://nomadlist.com"+city['media']['image']['1000']
      px1500 = "https://nomadlist.com"+city['media']['image']['1500']
      nightlife = city['scores']['nightlife']
      safety = city['scores']['safety']
      free_wifi_available = city['scores']['free_wifi_available']
      city_record = City.create(name: name, country: country, region: region, latitude: latitude, longitude: longitude, internet_download_speed: internet_download_speed, wiki_slug: wiki_slug, flickr_tag: flickr_tag)
      cost_record = Cost.create(cities_id: city_record.id, airbnb_median: airbnb_median, airbnb_vs_apartment_price_ratio: airbnb_vs_apartment_price_ratio, beer_in_cafe: beer_in_cafe, coffee_in_cafe: coffee_in_cafe, hotel: hotel, non_alcoholic_drink_in_cafe: non_alcoholic_drink_in_cafe)
      score_record = Score.create(cities_id: city_record.id, nightlife: nightlife, safety: safety, free_wifi_available: free_wifi_available)
      featured_image_record = FeaturedImage.create(cities_id: city_record.id, px250: px250, px500: px500, px1000: px1000, px1500: px1500)

    end
  else
    puts "ERROR: The database seems to have some seed data in place.\nPlease run following rake tasks (in given order) before attempting to seed:\n\t'rake db:drop',\n\t'rake db:create',\n\t'rake db:migrate'"
  end

end

desc 'Get first page of Flickr Images response by City tag and store full hyperlink in database'
task "fetch:flickr" do
if City.count > 0 && Photo.count == 0
    cities = City.all 
    cities.each do |city|
      city_name = city.flickr_tag
      flickr_api_key = ENV['FLICKR_AUTH_KEY']
      link = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{flickr_api_key}&tags=#{city_name}&format=json&nojsoncallback=1"
      # encode url and parse as some city names have specal characters e.g. Kraków
      # this should have been dealt with when making 'flickr_tag'. TODO: edit fetch:nomad_list to clean flickr_tag
      encoded_link = URI.encode(link)
      flickr_data_for_city = JSON.parse(open(URI.parse(encoded_link)).read)
      if flickr_data_for_city['photos']['total'].to_i > 0
        flickr_data_for_city['photos']['photo'].each do |photo|
          farm = photo['farm']
          server = photo['server']
          id = photo['id']
          secret = photo['secret']
          image_link = "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}.jpg"
          title = photo['title']
          Photo.create(cities_id: city.id, title: title, link: image_link)
        end
      end
    end
  else
    puts "ERROR: The database seems to have some seed data in place.\nPlease run following rake tasks (in given order) before attempting to seed:\n\t'rake db:drop'\n\t'rake db:create'\n\t'rake db:migrate'\n\t'rake fetch:nomad_list'"
  end
end