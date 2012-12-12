remote_file "#{Chef::Config[:file_cache_path]}/BetterTouchTool.zip" do
  source node["bettertouchtool_download_uri"]
  owner WS_USER
  action :create_if_missing
end

execute "unzip BetterTouchTool to /Applications" do
  command "unzip -o #{Chef::Config[:file_cache_path]}/BetterTouchTool.zip -x __MACOSX* -d /Applications/"
  user WS_USER
  not_if { File.exists?(node["bettertouchtool_app_path"]) }
  # This is required to unzip into Applications
  group "admin"
end

ruby_block "test to see if BetterTouchTool was installed" do
  block do
    raise "BetterTouchTool install failed" unless File.exists?(node["bettertouchtool_app_path"])
  end
end
