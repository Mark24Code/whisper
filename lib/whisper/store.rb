require_relative "./core/base"

module Whisper
  class Store < Model
    attr_accessor :app
    attr_reader :timelines, :test_content

    # 以后只能整体赋值，以触发自动更新
    # TODO 最后使用 setter_missing 使用自动触发
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