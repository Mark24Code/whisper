require "whisper/version"
require "tty-box"
require "tty-screen"
require "whisper/utils"
require "whisper/routes"
require "whisper/pub_sub"

module Whisper
  class Error < StandardError; end

  class App 
    def initialize
      @queue = []
    end  

    def layout
      ['ui_hello_world']
    end


    def render
      system("clear")
      self.layout.each do |component|
        print self.send component
      end
    end

    def ui_hello_world
      return TTY::Box.frame do
          "hello world"
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
          if @timelines.length >= 10
            @timelines.shift
          end
          @timelines.push(timeline)
        when ":connect"
          puts "connect",content
        else
          puts "[error]: no command"
      end
    end

    def main_loop
      # TODO load config
      while true
        # TODO check window size
        # TODO check main queue & run
        # TODO network input
        # render ui
        self.render
      end
    end

    def run
      self.main_loop
    end
  end

  class Component
    def initialize
    end  

    def render
    end
  end

  class MainFrame < Component
    attr_accessor :timelines
    def initialize
      super
      @timelines = []
      @local_ip = Utils::get_local_ip
      @version = Whisper::VERSION
    end

    def render
      timelines_text = ""
      
      @timelines.each do |timeline|
        timelines_text = timelines_text+"#{Time.at(timeline.first).strftime("%Y-%m-%d %H:%M:%S") } #{timeline.last}\n"
      end

      return TTY::Box.frame(
        width: TTY::Screen.width, 
        height: TTY::Screen.height/3*2,
        title: {top_left: @local_ip, bottom_right: @version}) do
          timelines_text
      end
    end
  end
end
