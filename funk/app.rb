require "sinatra"
require "kommando"

if settings.development?
  require "pry-byebug"
  require "sinatra/reloader"
end

get "/" do
  ""
end

get "/v1" do
  uuid = SecureRandom.uuid
  image = params[:image]
  cmd = params[:cmd]
  timeout = ENV.fetch 'FUNK_TIMEOUT'

  return "?image required" unless image
  return "?cmd required" unless cmd

  Kommando.run "./run.sh #{uuid} #{timeout} #{image} #{cmd}", {
    output: true
  }
  output = File.read "output_#{uuid}"
  File.unlink "output_#{uuid}"

  output
end

get "/health" do
  "ok"
end
