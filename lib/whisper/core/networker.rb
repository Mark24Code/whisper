require "sinatra/base"
require "json"
require "net/http"
require "uri"

require_relative "../settings"

class NetWorker < Sinatra::Base
  
  local_host = Whisper::Config[:host]
  local_port = Whisper::Config[:port]
  target_host = Whisper::Config[:target_host]
  target_port = Whisper::Config[:target_port]


  configure do
    set :bind, local_host
    set :port, local_port
  end

  # routes
  get '/' do
    'Welcome Whisper'
  end

  post '/timeline/receive' do
    timeline = params[:timeline]
    puts 'POST'
    puts timeline
    # @action.routes(timeline)
    # @app.rerender

    "receive success"
  end

  get '/ping' do
    JSON.dump({"code": 200, "data": "connect success"})
  end
end

