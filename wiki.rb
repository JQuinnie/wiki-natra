require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  # insert erb template of file welcome.erb
  erb :welcome
end

