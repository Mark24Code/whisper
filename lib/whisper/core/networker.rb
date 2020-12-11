require "sinatra/base"
require "json"
require "net/http"
require "uri"
require_relative "../store"

require_relative "../settings"

class NetWorker < Sinatra::Base
  
  local_host = Whisper::Config[:host]
  local_port = Whisper::Config[:port]

  @@store = nil

  class << self
    def store=(store)
      @@store = store
    end
    def store
      @@store
    end
  end

  configure do
    set :bind, local_host
    set :port, local_port
    set :logging, false
  end

  # routes
  get '/' do
    'Welcome Whisper'
  end

  post '/timeline/receive' do

    timeline = params[:timeline]
    timeline = JSON.parse(timeline)

    timelines = @@store.get(:timelines)
    if timelines.length >= 20
      timelines.shift
    end

    timelines.push timeline
    @@store.set(:timelines, timelines)
    "receive success"
  end

  get '/ping' do
    JSON.dump({"code": 200, "data": "connect success"})
  end
end

