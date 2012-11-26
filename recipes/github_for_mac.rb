unless File.exists?(node["github_for_mac_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/github_for_mac.zip" do
    source node["github_for_mac_download_uri"]
    owner WS_USER
    checksum "b21158e5d76583097a8d7f6d2f6f5cea0ff78852711390ec6c05f94625ec0248"
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
