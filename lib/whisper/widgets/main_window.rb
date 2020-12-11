require "whisper/core/base"
require "tty-box"
require "tty-screen"
require "whisper/helpers"
include Whisper::Helpers

module Whisper
  class MainWindow
    attr_accessor :timelines
  
    def initialize(timelines)
      @timelines = timelines
      @local_host = get_local_ip
      @version = Whisper::VERSION
    end

    def render
      timelines_text = ""
      
      @timelines.each do |timeline|
        timelines_text = timelines_text+"#{timeline.last == @local_host ? 'Me:': 'Friend:'} #{Time.at(timeline.first).strftime("%Y-%m-%d %H:%M:%S") } #{timeline[2]}\n"
      end

      return TTY::Box.frame(
        width: TTY::Screen.width, 
        height: TTY::Screen.height/3*2,
        title: {top_left: @local_ip, bottom_right: @version}) do
          timelines_text
      end
    end
  end
end