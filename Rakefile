require 'rake'
require 'dotenv/tasks'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

desc "create the database"
task "db:create" do
  conn = PG.connect(dbname:'postgres')
  puts "Database 'app_vakanz' CREATED successfully" if conn.exec('CREATE DATABASE app_vakanz')
end

desc "drop the database"
task "db:drop" do
  conn = PG.connect(dbname:'postgres')
  puts "Database 'app_vakanz' DROPPED successfully" if conn.exec('DROP DATABASE app_vakanz')
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end


desc 'Retrieves (scrapes) Weather Data from Wikipedia City pages and store in DB'
task "fetch:wikipedia" do
  if City.count > 0 && DailyMeanTemperature.count == 0
    list_of_cities_with_name_issues = Array.new
    cities = City.all
    
    cities.each do |city|
      
      wiki_page = "https://en.wikipedia.org/wiki/#{city.wiki_slug}"
      wiki_extract = Nokogiri::HTML(open(URI.encode(wiki_page)))
      response = wiki_extract.css("div#mw-content-text > table.wikitable.collapsible > tr")[1] # check if table exists, chang this to check if the title includes the word 'Climate' to be precise!
      
      unless response.is_a?(Nokogiri::XML::Element)
        list_of_cities_with_name_issues << city.wiki_slug # skip to next city if table doesn't exist and add city to array resolve name issues after version ALPHA and fetch relevant data
        next
      end
      
      # extract the weather data and store in relevant tables: average_high_temperatures, average_low_temperatures, daily_mean_temperatures
      # loop through table rows
      wiki_table_rows = wiki_extract.css("div#mw-content-text > table.wikitable.collapsible > tr")
        
        wiki_table_rows.each do |row|
          
          # store average highs in degrees celcius
          if row.css("th").text == "Average high °C (°F)"
            row.css("td")[0..-2].each_with_index do |data_point, index|
              AverageHighTemperature.create(cities_id:city.id, months_id: index+1, temperature: data_point.text[0..4])
            end
          end
          
          # store daily means in degrees celcius
          if row.css("th").text == "Daily mean °C (°F)"
            row.css("td")[0..-2].each_with_index do |data_point, index|
              DailyMeanTemperature.create(cities_id:city.id, months_id: index+1, temperature: data_point.text[0..4])
            end
          end
          
          # store average lows in degrees celcius
          if row.css("th").text == "Average low °C (°F)"
            row.css("td")[0..-2].each_with_index do |data_point, index|
              AverageLowTemperature.create(cities_id:city.id, months_id: index+1, temperature: data_point.text[0..4])
            end
          end

        end

      end
      
  else
    puts "ERROR: The database seems to have some seed data in place.\nPlease run following rake tasks (in given order) before attempting to seed:\n\t'rake db:drop'\n\t'rake db:create'\n\t'rake db:migrate'\n\t'rake fetch:nomad_list'"
  end
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
      if name == 'Kinosaki-Onsen'
        wiki_slug = 'Kinosaki,_Hyōgo'
      elsif name == 'Krivoy-Rog'
        wiki_slug = 'Kryvyi Rih'
      else
        wiki_slug = name.gsub(/\s/,"_")
      end
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
      monthsToVisit = city['info']['monthsToVisit'] # returns array of month values

      city_record = City.create(name: name, country: country, region: region, latitude: latitude, longitude: longitude, internet_download_speed: internet_download_speed, wiki_slug: wiki_slug, flickr_tag: flickr_tag)
      cost_record = Cost.create(cities_id: city_record.id, airbnb_median: airbnb_median, airbnb_vs_apartment_price_ratio: airbnb_vs_apartment_price_ratio, beer_in_cafe: beer_in_cafe, coffee_in_cafe: coffee_in_cafe, hotel: hotel, non_alcoholic_drink_in_cafe: non_alcoholic_drink_in_cafe)
      score_record = Score.create(cities_id: city_record.id, nightlife: nightlife, safety: safety, free_wifi_available: free_wifi_available)
      featured_image_record = FeaturedImage.create(cities_id: city_record.id, px250: px250, px500: px500, px1000: px1000, px1500: px1500)
      monthsToVisit.each do |month|
        IdealMonth.create(cities_id: city_record.id, months_id: month)
      end
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