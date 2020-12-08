require "whisper/core/base"
require "net/http"
require "uri"
require "socket"
require "whisper/helpers"
include Whisper::Helpers

require_relative "./settings"


module Whisper
  class Action
    def initialize(store)
      @store = store
      self.networker_run
    end  

    def networker_run
      puts "networker_run"
      require_relative "./core/networker"
      Thread.new do
        NetWorker.run!
      end
    end

    def routes(line="")
      if line.match? COMMAND_PATTERN
        timeline = get_meta_info(line)
    
        dispatcher(timeline)
      else
        msg = ":message #{line}"
        routes(msg)
      end
    end
    
    def dispatcher(timeline)
      timestamp, command, content = timeline
    
      case command
        when ":exit"
          puts "[global] See you later :)"
    
          # Todo LifeCycle BeforeExit
          exit
        when ":message"
          # Todo 封装成独立的数据结构
          if @store.timelines.length >= 10
            @store.timelines.shift
          end
          @store.timelines.push(timeline)
          self.send(timeline)
        when ":connect"
          puts "connect",content
        else
          puts "[error]: no command"
      end
    end

    def send(data)
      target_host = Whisper::Config[:target_host]
      target_port = Whisper::Config[:target_port]

      url_string = "http://#{target_host}:#{target_port}/timeline/receive"
      puts url_string
      uri = URI.parse(url_string)
      puts uri
      response = Net::HTTP.post_form(uri, {"timeline" => data})
    end

    def listen
    
    end
  end
end