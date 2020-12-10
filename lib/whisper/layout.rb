require "whisper/core/base"

require "whisper/widgets/helloword"
require "whisper/widgets/main_window"

module Whisper
  class Layout < Component
    def initialize(store)
      @store = store
    end 
  
    def render
      timelines = @store.get(:timelines)
      test_content = @store.get(:test_content)
      return [
        HelloWorld.new.render(test_content),
        MainWindow.new(timelines).render,
      ]
    end
  end  
end

