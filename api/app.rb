require "sinatra"

if settings.development?
  require 'sinatra/reloader'
end

get "/" do
  "funk"
end
