module Whisper
  # abs class
  class Error < StandardError; end

  class ContainerComponent
    def initialize
    end  

    def render
    end
  end

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

  # framework
  class Framework
    def initialize(models,views,controllers)
      @models = models
      @views = views
      @controllers = controllers
    end  

    def render
      system("clear")
      @views.render.each do |instance|
        puts instance
      end
    end

    def main_loop
      while true
        self.render
        input = gets
        @controllers.routes(input)
      end
    end

    def run
      self.main_loop
    end
  end
end