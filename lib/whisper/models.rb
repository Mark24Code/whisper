require "whisper/core/framework"

module Whisper
  class Store < Model
    attr_accessor :data
    def initialize
      super
      @data = {
        'test_content': 'Hello World',
        'timelines': []
      }
    end
  end
end