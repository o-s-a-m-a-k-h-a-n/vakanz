# Homepage (Root path)
get '/' do
  erb :index
end

get '/results' do
  erb :results, layout: :results_layout
end