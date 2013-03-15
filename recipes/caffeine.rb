remote_file "#{Chef::Config[:file_cache_path]}/caffeine.zip" do
  source node["caffeine_download_uri"]
  owner WS_USER
  checksum node["caffeine_sha"]
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/caffeine.zip") }
end

execute "unzip caffeine" do
  command "unzip #{Chef::Config[:file_cache_path]}/caffeine.zip -d #{Chef::Config[:file_cache_path]}/"
  user WS_USER
  not_if { File.exists?("#{Chef::Config[:file_cache_path]}/Caffeine.app") }
end

execute "copy caffeine to /Applications" do
  command "mv #{Chef::Config[:file_cache_path]}/Caffeine.app #{Regexp.escape(node["caffeine_app_path"])}"
  user WS_USER
  group "admin"
  not_if { File.exists?(node["caffeine_app_path"]) }
end

cookbook_file "/Users/#{WS_USER}/Library/Preferences/com.lightheadsw.Caffeine.plist" do
  source "com.lightheadsw.Caffeine.plist"
  mode 0644
  owner WS_USER
  group "admin"
end

ruby_block "test to see if Caffeine.app was installed" do
  block do
    raise "Caffeine.app was not installed" unless File.exists?(node["caffeine_app_path"])
  end
end
