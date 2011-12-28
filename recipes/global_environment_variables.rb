template "/etc/launchd.conf" do
  source "launchd.conf.erb"
  mode "0644"
end