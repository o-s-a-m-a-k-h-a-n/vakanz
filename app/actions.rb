get '/' do
  erb :index
end

get '/search' do
  # optional TODO: validate params like location
  erb :search
end

