unless File.exists?(node["github_for_mac_app_path"])

  remote_file "/tmp/github_for_mac.zip" do
    source node["github_for_mac_download_uri"]
    owner WS_USER
  end

  execute "unzip github_for_mac" do
    command "unzip /tmp/github_for_mac.zip -d /tmp/"
    user WS_USER
  end

  execute "copy github_for_mac to /Applications" do
    command "mv /tmp/GitHub.app #{Regexp.escape(node["github_for_mac_app_path"])}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if GitHub.app was installed" do
    block do
      raise "GitHub.app was not installed" unless File.exists?(node["github_for_mac_app_path"])
    end
  end
  
end