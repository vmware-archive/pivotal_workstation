WS_USER = ENV['SUDO_USER'].strip
WS_HOME = ENV['HOME']

raise "should not be root" if WS_USER=="root"