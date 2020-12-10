require "sinatra/base"
require "json"
require "net/http"
require "uri"
require_relative "../store"

require_relative "../settings"

class NetWorker < Sinatra::Base
  
  local_host = Whisper.config[:host]
  local_port = Whisper.config[:port]

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
  end

  # routes
  get '/' do
    'Welcome Whisper'
  end

  post '/timeline/receive' do

    timeline = params[:timeline]
    timeline = JSON.parse(timeline)
    @@store.db.transaction do 
      timelines = @@store.db[:timelines]
      if timelines.length >= 20
        timelines.shift
      end

      timelines.push timeline
      @@store.db[:timelines] = timelines
    end
    "receive success"
  end

  get '/ping' do
    JSON.dump({"code": 200, "data": "connect success"})
  end
end

