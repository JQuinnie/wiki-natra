require 'sinatra'

set :bind, '0.0.0.0'

# method to load text files
def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

get '/' do
  # insert erb template of file welcome.erb
  erb :welcome
end

get '/:title' do
  page_content(params[:title])
end
