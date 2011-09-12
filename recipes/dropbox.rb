unless File.exists?("/Applications/Dropbox.app")

  remote_file "/tmp/dropbox.dmg" do
    source node["dropbox_download_uri"]
    mode "0644" 
  end
  
  execute "mount dropbox dmg" do
    command "hdid /tmp/dropbox.dmg"
    user WS_USER
  end

  execute "copy dropbox to /Applications" do
    # use rsync instead of cp because /Dropbox.app/Contents/Resources/lib/python2.5/site.py
    # is a broken link, and cp exits non-zero
    command "rsync -a /Volumes/Dropbox\\ Installer/Dropbox.app /Applications/"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach /Volumes/Dropbox\\ Installer"
    user WS_USER
  end

  ruby_block "test to see if Dropbox was installed" do
    block do
      raise "Dropbox install failed" unless File.exists?("/Applications/Dropbox.app")
    end
  end
end
