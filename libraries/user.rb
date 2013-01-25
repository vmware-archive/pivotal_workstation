raise "sudo to root before running" if ENV['SUDO_USER'].nil?

WS_USER = ENV['SUDO_USER'].strip

# Some computers have "always_set_home" configured in the 
# /etc/sudoers file for security. Instead of assuming that
# environment variables are preserved, manually build the
# HOME directory.
#
# I *think* that this one line would be good enough without
# the "if WS_HOME == "/root" check above, but to ensure that
# no scripts break on other platforms only perform this
# change if the home directory *is* actually root.
if ENV['HOME'] == "/root"
  ENV['HOME'] = WS_HOME = "/home/#{WS_USER}"
else
  WS_HOME = ENV['HOME']
end

# This is a Mac-only variable which doesn't appear to be used
# so I will comment it out so no one starts using it
#WS_LIBRARY = "#{WS_HOME}/Library"

raise "should not be root" if WS_USER=="root"
raise "directory should not be /root" if WS_HOME=="/root"
