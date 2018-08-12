require 'sinatra'

set :bind, '0.0.0.0'

get '/' do
  '<h1>Welcome to Wiki-Natra</h1>'
end

