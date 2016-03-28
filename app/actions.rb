require 'pry'

get '/' do
  erb :index
end

get '/search' do
  # return to homepage if user doesn't provide parameters to request
  if params.empty?
    redirect '/'
  else
    @searched_city = params['location']
    @city_name = @searched_city[0, @searched_city.index(',')]
    @city_data = City.find_by(name: @city_name)
    binding.pry
    erb :search
  end
end

