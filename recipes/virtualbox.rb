# found package name by mounting dmg and
# cat /Volumes/VirtualBox/VirtualBox.mpkg/Contents/Packages/VirtualBox.pkg/Contents/Info.plist 
# note, there are 4 packages in the mpkg
`pkgutil --pkgs=org.virtualbox.pkg.virtualbox`
if $? != 0

  remote_file "/tmp/virtualbox.dmg" do
    source node["virtualbox_download_uri"]
    mode "0644" 
  end

  execute "mount virtualbox dmg" do
    command "hdid /tmp/virtualbox.dmg"
    user WS_USER
  end

  execute "intall virtualbox" do
    command "installer -pkg /Volumes/VirtualBox/VirtualBox.mpkg -target /"
  end

  execute "unmount dmg" do
    command "hdiutil detach /Volumes/VirtualBox"
    user WS_USER
  end

  ruby_block "test to see if virtualbox was installed" do
    block do
      `pkgutil --pkgs=org.virtualbox.pkg.virtualbox`
      raise "VirtualBox install failed" if $? != 0
    end
  end
end
