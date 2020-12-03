module Utils
  def self.get_local_ip
    require 'socket'
    ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    ip.ip_address
  end
end