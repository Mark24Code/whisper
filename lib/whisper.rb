require "whisper/version"
require "cli/ui"
require "whisper/utils"

require "whisper/routes"

module Whisper
  class Error < StandardError; end

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

  CLI::UI::Frame.open('Frame 2') { puts "inside frame 2" }

  while true
    input = gets
    routes(input)
  end
end
