require "whisper/core/base"
require "net/http"
require "uri"
require "socket"
require_relative "./settings"
require_relative "./store"
require "whisper/helpers"
require "json"
include Whisper::Helpers

module Whisper
  class Action
    def initialize(store)
      @store = store
      self.networker_run
    end  

    def networker_run
      puts "networker_run"
      require_relative "./core/networker"

      NetWorker.store = @store

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
      timestamp, command, content, ip_address = timeline
    
      case command
        when ":exit"
          puts "[global] See you later :)"
    
          # Todo LifeCycle BeforeExit

          # $PWD是 根目录
          system "rm ./#{Whisper::Config[:local_db_name]}"
          exit
        when ":message"
          # TODO 效率低
          timelines = @store.get(:timelines)

          if timelines.length > 20
            timelines.shift
          end
          timelines.push(timeline)

          @store.set(:timelines, timelines)
          self.send(timeline)
        when ":connect"
          target_host,target_port = content.split(":")
          target_host.strip!
          target_port.strip!

          @store.set(:target_host, target_host != ''? target_host: nil)
          @store.set(:target_port, target_port != '' ? target_port: nil)
          puts "connect:",content
        else
          puts "[error]: no command"
      end
    end

    def send(data)
      target_host = @store.get(:target_host)
      target_port = @store.get(:target_port) ||  Whisper::Config[:target_port]

      if !target_host
        puts "You need input `:connect <target ip>` first"
        return
      end
  
      url_string = "http://#{target_host}:#{target_port}/timeline/receive"
      uri = URI.parse(url_string)
      response = Net::HTTP.post_form(uri, {"timeline" => JSON.dump(data)})
    end
  end
end