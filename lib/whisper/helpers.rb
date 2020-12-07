require "time"

COMMAND_PATTERN = /^:([connect|message|exit])(.*?)/

module Whisper
  module Helpers
    def get_meta_info(raw_string)
      first_gap_index = raw_string.index(" ")
      command = raw_string[0..first_gap_index].strip
      content = raw_string[first_gap_index..].strip
      timestamp = Time.now.to_i

      return [timestamp, command, content]
    end

    def get_local_ip
      require 'socket'
      ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
      ip.ip_address
    end
  end
end

