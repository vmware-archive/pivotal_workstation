Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

template "/etc/launchd.conf" do
  source "launchd.conf.erb"
  mode "0644"
end
