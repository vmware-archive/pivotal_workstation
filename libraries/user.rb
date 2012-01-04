WS_USER = ENV['SUDO_USER'].strip
WS_HOME = ENV['HOME']
WS_LIBRARY = "#{WS_HOME}/Library"

raise "should not be root" if WS_USER=="root"
