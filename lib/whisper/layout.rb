require "whisper/core/framework"

require "whisper/widgets/helloword"
require "whisper/widgets/main_window"

module Whisper
  class Layout < ContainerComponent
    def initialize(model)
      @model = model
    end 
  
    def render
      hello = @model[:test_content]
      timelines = @model[:timelines]
      return [
        HelloWorld.new.render(hello),
        MainWindow.new(timelines).render,
      ]
    end
  end  
end

