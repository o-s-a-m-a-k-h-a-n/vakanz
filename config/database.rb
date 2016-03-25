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
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

end
