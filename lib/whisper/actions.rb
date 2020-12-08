require "whisper/core/base"
require "whisper/helpers"
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
        when ":connect"
          puts "connect",content
        else
          puts "[error]: no command"
      end
    end

    def send(time)
    
    end
  end
end