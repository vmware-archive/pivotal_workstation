unless File.exists?("/Applications/Google Chrome.app")

  remote_file "/tmp/chrome.dmg" do
    source node["chrome_download_uri"]
    mode "0644" 
  end
  
  execute "mount chrome dmg" do
    command "hdid /tmp/chrome.dmg"
    user WS_USER
  end

  execute "copy chrome to /Applications" do
    command "cp -rf /Volumes/Google\\ Chrome/Google\\ Chrome.app /Applications/"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach /Volumes/Google\\ Chrome"
    user WS_USER
  end

  ruby_block "test to see if Chrome was installed" do
    block do
      raise "Chrome install failed" unless File.exists?("/Applications/Google Chrome.app")
    end
  end
end
