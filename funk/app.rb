require "sinatra"
require "sinatra/streaming"
require "kommando"

class IO
  def read_nonblocking(size)
    return read_nonblock(size)
  rescue IO::EAGAINWaitReadable
    return ""
  rescue EOFError
    return nil
  end
end

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

  env_file = File.new "env_#{uuid}", "w"
  request.env.each_pair do |k,v|
    next unless matches = k.match(/^HTTP_X_FUNK_ENV_(.*)$/)
    env = matches[1]
    env_file.puts "-e #{env}=#{v}"
  end
  env_file.close

  k = Kommando.run_async "./run.sh #{uuid} #{timeout} #{image} #{cmd}", {
    output: true
  }

  output_file = "output_#{uuid}"

  loop do
    break if File.exist? output_file
    sleep 0.1
  end

  io = IO.popen("tail -f #{output_file}")
  stream do |out|
    loop do
      s = io.read_nonblocking(4096)
      out.write s
      break if k.code
    end
    out.flush
  end
end

get "/health" do
  "ok"
end
