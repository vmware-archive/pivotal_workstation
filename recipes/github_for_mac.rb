remote_file "#{Chef::Config[:file_cache_path]}/github_for_mac.zip" do
  source node["github_for_mac_download_uri"]
  owner WS_USER
  checksum node["github_for_mac_sha"]
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/github_for_mac.zip") }
end

execute "unzip github_for_mac" do
  command "unzip #{Chef::Config[:file_cache_path]}/github_for_mac.zip -d #{Chef::Config[:file_cache_path]}/"
  user WS_USER
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/GitHub.app") }
end

execute "copy github_for_mac to /Applications" do
  command "mv #{Chef::Config[:file_cache_path]}/GitHub.app #{Regexp.escape(node["github_for_mac_app_path"])}"
  user WS_USER
  group "admin"
  not_if { File.exists?(node["github_for_mac_app_path"]) }
end

ruby_block "test to see if GitHub.app was installed" do
  block do
    raise "GitHub.app was not installed" unless File.exists?(node["github_for_mac_app_path"])
  end
end
