unless File.exists?("/Applications/Skype.app")

  remote_file "/tmp/skype.dmg" do
    source node["skype_download_uri"]
    mode "0644" 
  end
  
  execute "mount skype dmg" do
    command "hdid /tmp/skype.dmg"
    user WS_USER
  end

  execute "copy skype to /Applications" do
    command "cp -rf /Volumes/Skype/Skype.app /Applications/"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach /Volumes/Skype"
    user WS_USER
  end

  ruby_block "test to see if Skype was installed" do
    block do
      raise "Skype install failed" unless File.exists?("/Applications/Skype.app")
    end
  end
end
