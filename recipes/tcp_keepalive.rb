pivotal_workstation_sysctl "send keepalive packets" do
  name "net.inet.tcp.always_keepalive"
  value "1"
end

pivotal_workstation_sysctl "send keepalive packets every 74.5 seconds" do
  name "net.inet.tcp.keepidle"
  value "149000"
end
