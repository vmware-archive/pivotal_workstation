Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

cookbook_file "/etc/snmp/snmpd.conf" do
  source "snmpd.conf"
  mode "0644"
end

execute "launchctl load -w /System/Library/LaunchDaemons/org.net-snmp.snmpd.plist"
