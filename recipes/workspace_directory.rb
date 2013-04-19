Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

directory "#{WS_HOME}/#{node["workspace_directory"]}" do
  owner WS_USER
  mode "0755"
  action :create
end
