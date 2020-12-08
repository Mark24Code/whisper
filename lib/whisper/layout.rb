require "whisper/core/base"

require "whisper/widgets/helloword"
require "whisper/widgets/main_window"

module Whisper
  class Layout < Component
    def initialize(store)
      @props = store
    end 
  
    def render
      hello = @props.test_content
      timelines = @props.timelines
      return [
        HelloWorld.new.render(hello),
        MainWindow.new(timelines).render,
      ]
    end
  end  
end

