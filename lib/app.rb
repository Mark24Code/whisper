require "whisper/core/base"
require "whisper/version"

require "whisper/layout"
require "whisper/instances"

module Whisper
  class App < Base
    def initialize
      super
      @store = Whisper::StoreInstance
      @layout = Layout.new(@store)
      @action = Whisper::ActionInstance
    end
  end
end