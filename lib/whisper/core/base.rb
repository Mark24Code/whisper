module Whisper
  # abs class
  class Error < StandardError; end

  class Component
    def initialize
    end  

    def render
    end
  end


  class Model
    def initialize
    end
  end

  # base
  class Base
    attr_accessor :store, :layout, :action, :app
    def initialize
      @store = store
      @layout = layout
      @action = action

      @app = self
    end  

    def render
      system("clear")

      materials = @layout.render
      if materials.kind_of? Array
        materials.each do |widget|
          puts widget
        end
      else
        puts materials
      end
    end

    def rerender
      self.render
    end

    def main_loop
      while true
        self.render
        input = gets
        @action.routes(input)
      end
    end

    def networker_run
      puts "networker_run"
      require_relative "./networker"
      Thread.new do
        NetWorker.run!
      end
    end

    def run
      self.networker_run
      self.main_loop
    end
  end
end