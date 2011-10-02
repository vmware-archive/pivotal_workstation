hostnames=[`hostname`.chop]

require 'socket'
real_interfaces = `netstat -ni`.split("\n").select {|line| line.match(/en.*((\d+\.){3}\d+)/) }
host_ips = real_interfaces.collect {|line| line.match(/en.*?((\d+\.){3}\d+)/); Regexp.last_match(1) }
host_ips.each do |ip|
  begin
    hostnames << Socket.gethostbyaddr(ip.split(/\./).collect! {|i| i.to_i }.pack('CCCC'))[0]
  rescue SocketError
    log "no reverse lookup for \"#{ip}\""
  end
end

hostnames.each do |hostname|
  log "My hostname: #{hostname}"
  if hostname =~ /pivotallabs.com/ and hostname !~ /^dyn-/
    hostname = hostname.gsub(/\..*/,"")

    # The scutil commands need to run as root, unless
    # you're logged into the console, but we can't be sure of that.
    execute "set the user friendly name for this system to #{hostname}" do
      command "scutil --set ComputerName #{hostname}"
    end

    execute "set the local bonjour hostname for this system to #{hostname}" do
       command "scutil --set LocalHostName #{hostname}"
     end

    execute "set the hostname for this system" do
       command "scutil --set HostName #{hostname}"
     end

    execute "set the hostname for this system for the current session to #{hostname}" do
       command "hostname #{hostname}"
    end

    execute "set the diskname this system to #{hostname}" do
       command "diskutil rename / #{hostname}"
       user WS_USER
    end

    ruby_block "test to see if hostname was set" do
      block do
        raise "Setting of hostname failed" unless hostname == `scutil --get ComputerName`.chop
      end
    end
  end
end
