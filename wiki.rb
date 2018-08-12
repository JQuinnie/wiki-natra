require 'sinatra'

set :bind, '0.0.0.0'

# method to load text files
def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  return nil
end

# method to save content to text file
def save_content(title, content)
  File.open("pages/#{title}.txt", "w") do |file|
    file.print(content)
  end
end

get '/' do
  # insert erb template of file welcome.erb
  erb :welcome
end

# using URL parameters to create a single route that will match any page users might attempt to visit
get '/:title' do
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end
