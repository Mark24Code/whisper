require "whisper/core/base"
require "whisper/version"

require "whisper/store"
require "whisper/layout"
require "whisper/actions"



module Whisper
  class App < Base
    def initialize
      super
      @store = Store.new(self)
      @layout = Layout.new(@store)
      @action = Action.new(@store)
    end
  end
end