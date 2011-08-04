unless File.exists?(node["firefox_app_path"])

  remote_file "/tmp/firefox.dmg" do
    source node["firefox_download_uri"]
    mode "0644" 
  end
  
  execute "mount firefox dmg" do
    command "hdid /tmp/firefox.dmg"
    user WS_USER
  end
  
  execute "copy firefox to /Applications" do
    command "cp -rf /Volumes/Firefox/Firefox.app #{Regexp.escape(node["firefox_app_path"])}"
    user WS_USER
  end
  
  execute "unmount dmg" do
    command "hdiutil detach /Volumes/Firefox"
    user WS_USER
  end

  ruby_block "test to see if Firefox was installed" do
    block do
      raise "Firefox install failed" unless File.exists?(node["firefox_app_path"])
    end
  end
end
