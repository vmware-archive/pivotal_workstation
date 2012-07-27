unless File.exists?(node["github_for_mac_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/github_for_mac.zip" do
    source node["github_for_mac_download_uri"]
    owner WS_USER
    checksum "1e95b3c16915efe171e53c2de31ae5b0b45cca6689a6923baa96cf754a06ed73"
  end

  execute "unzip github_for_mac" do
    command "unzip #{Chef::Config[:file_cache_path]}/github_for_mac.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy github_for_mac to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/GitHub.app #{Regexp.escape(node["github_for_mac_app_path"])}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if GitHub.app was installed" do
    block do
      raise "GitHub.app was not installed" unless File.exists?(node["github_for_mac_app_path"])
    end
  end

end
