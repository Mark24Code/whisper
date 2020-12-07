require "whisper/core/framework"
require "tty-box"

module Whisper
  class HelloWorld < Component
    def render(content)
      return TTY::Box.frame do
        return "#{content}"
      end
    end
  end
end