require "sinatra"
require "uri"

set :bind, "0.0.0.0"

# for security purpose, add method to escape any HTML that might appear as a string in page's content
def h(string)
  Rack::Utils.escape_html(string)
end

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

# method to delete text file from pages
def delete_content(title)
  File.delete("pages/#{title}.txt")
end

get "/" do
  # insert erb template of file welcome.erb
  erb :welcome
end

get "/new" do
  erb :new
  # if need to use a different layout specification, call as below
  # erb :new, layout: :page
end

# using URL parameters to create a single route that will match any page users might attempt to visit
get "/:title" do
  @title = params[:title]
  @content = page_content(@title)
  erb :show
end

# using URL parameter of the title to allow an edit route
get "/:title/edit" do
  @title = params[:title]
  @content = page_content(@title)
  erb :edit
end

# {"title" => "my title", "content" => "my content"}
post "/create" do
  save_content(params["title"], params["content"])
  # after successful save, it will redirect to path specified
  # CGI::espape replaced URI.escape to encode spaces in route
  redirect URI.escape("/#{params["title"]}")
end

# put request for modifying an existing resource on the server
put "/:title" do
  save_content(params["title"], params["content"])
  redirect URI.escape("/#{params["title"]}")
end

# linking delete route
delete "/:title" do
  delete_content(params[:title])
  redirect "/"
end
