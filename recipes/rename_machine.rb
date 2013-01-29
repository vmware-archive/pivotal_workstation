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
  if hostname =~ /#{node['machine_domain']}/ and hostname !~ /^dyn-/
    hostname = hostname.gsub(/\..*/,"")

    # The scutil commands need to run as root, unless
    # you're logged into the console, but we can't be sure of that.

    ["scutil --set ComputerName #{hostname}",
     "scutil --set LocalHostName #{hostname}",
     "scutil --set HostName #{hostname}",
     "hostname #{hostname}",
     "diskutil rename / #{hostname}" ].each do |host_cmd|
      execute host_cmd
    end

    ruby_block "test to see if hostname was set" do
      block do
        raise "Setting of hostname failed" unless hostname == `scutil --get ComputerName`.chop
      end
    end
  end
end
