WS_USER = ENV['SUDO_USER'].strip

raise "should not be root" if WS_USER=="root"