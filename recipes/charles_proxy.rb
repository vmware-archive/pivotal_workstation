# Recipe to install Charles Proxy
# http://www.charlesproxy.com/
#
# If you already have a license name and key, specify these in the
# node_attributes section of your `soloistrc` file to preinstall your
# license. eg:
#
# node_attributes:
#   charles_proxy:
#     license_name: Your Name
#     license_key: 7ad6c7a6c87...

remote_file "#{Chef::Config[:file_cache_path]}/charles_proxy.zip" do
  source node["charles_proxy"]["download_uri"]
  owner WS_USER
  checksum node["charles_proxy"]["sha"]
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/charles_proxy.zip") }
end

execute "unzip charles_proxy" do
  command "unzip #{Chef::Config[:file_cache_path]}/charles_proxy.zip -d #{Chef::Config[:file_cache_path]}/"
  user WS_USER
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/Charles.app") }
end

execute "copy charles_proxy to /Applications" do
  command "mv #{Chef::Config[:file_cache_path]}/Charles.app #{Regexp.escape(node["charles_proxy"]["app_path"])}"
  user WS_USER
  group "admin"
  not_if { File.exists?(node["charles_proxy"]["app_path"]) }
end

template node["charles_proxy"]["config_path"] do
  source "com.xk72.charles.config.erb"
  cookbook 'pivotal_workstation'
  owner WS_USER
  mode "0777"
  not_if { File.exists?(node["charles_proxy"]["config_path"]) || node["charles_proxy"]["license_key"] == nil || node["charles_proxy"]["license_name"] == nil }
end

ruby_block "test to see if Charles.app was installed" do
  block do
    raise "Charles.app was not installed" unless File.exists?(node["charles_proxy"]["app_path"])
  end
end
