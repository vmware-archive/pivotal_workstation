unless File.exists?(node["grid_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/Grid.app.zip" do
    source node["grid_download_uri"]
    owner WS_USER
  end

  execute "unzip grid" do
    command "unzip #{Chef::Config[:file_cache_path]}/Grid.app.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy grid to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Grid.app #{Regexp.escape(node["grid_app_path"])}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Grid.app was installed" do
    block do
      raise "Grid.app was not installed" unless File.exists?(node["grid_app_path"])
    end
  end

end
