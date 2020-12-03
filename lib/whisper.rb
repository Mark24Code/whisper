require "whisper/version"
require "cli/ui"
require "whisper/utils"

require "whisper/routes"

module Whisper
  class Error < StandardError; end

  class App
    def initialize
      self.run
    end

    def render_ui_main
      # Config
      CLI::UI::StdoutRouter.enable

      # Data
      message_box = []
      current_typing = ""
      # UI
      local_ip = Utils::get_local_ip()
      CLI::UI::Frame.open("Local IP:#{local_ip}") do
        puts "inside frame 1"
      end
    end


    def interactive_loop
      while true
        input = gets
        routes(input)
      end
    end

    def render
      # todo
    end

    def run
      self.render_ui_main
      self.interactive_loop
    end

  end
end
