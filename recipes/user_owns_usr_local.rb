Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

directory "/usr/local/bin" do
  owner WS_USER
  recursive true
end

execute "your current user owns /usr/local" do
  command "chown -R #{WS_USER} /usr/local"
end
