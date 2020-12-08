require_relative "./core/base"

module Whisper
  class Store < Model
    attr_accessor :app

    attr_reader :timelines, :test_content
    def initialize(app)
      @app = app
      @timelines = []
      @test_content = "Hello World"
    end

    def timelines=(new_val)
      @timelines = new_val
      @app.render
    end
  end
end