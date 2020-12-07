require "whisper/core/framework"
require "whisper/version"
require "whisper/core/pub_sub"

require "whisper/models"
require "whisper/layout"
require "whisper/controllers"

module Whisper
  class App
    def initialize
      @models = Store.new.data
      @views = Layout.new(@models)
      @controllers = Controller.new(@models)

      @app = Framework.new(@models,@views,@controllers)
    end  

    def run 
      @app.run
    end
  end
end