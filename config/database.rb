configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  # set :database, {
  #   adapter: "sqlite3",
  #   database: "db/db.sqlite3"
  # }

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

configure :development do
 
 ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: ENV['devdb-name'],
  username: ENV['devdb-user'],
  password: ENV['devdb-password'],
  host: ENV['devdb-host'],
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error',
  encoding: 'utf8'
   )
 set :show_exceptions, true
 puts "+++++ Connected to development database successfully +++++"
end

configure :production do
 
 ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'dad94e4eu0v7tt',
  username: 'ltunagcmksbtsc',
  password: 'Ktn47JeHRJOYeTTwYW7pVREgdx',
  host: 'ec2-54-227-254-152.compute-1.amazonaws.com',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error',
  encoding: 'utf8'
 )
end

end
