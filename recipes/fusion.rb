`pkgutil --pkgs=com.vmware.fusion.application`
if $? != 0

  remote_file "/tmp/fusion.dmg" do
    source node["fusion_download_uri"]
    mode "0644" 
  end
  
  execute "mount fusion dmg" do
    command "hdid /tmp/fusion.dmg"
    user WS_USER
  end
  
  execute "intall fusion" do
    command "installer -pkg /Volumes/VMware\\ Fusion/Install\\ VMware\\ Fusion.app/Contents/Resources/Install\\ VMware\\ Fusion.mpkg -target /"
  end

  execute "unmount dmg" do
    command "hdiutil detach /Volumes/VMware\\ Fusion/Install\\ VMware\\ Fusion.app"
    user WS_USER
  end

  ruby_block "test to see if fusion was installed" do
    block do
      `pkgutil --pkgs=com.vmware.fusion.application`
      raise "Fusion install failed" if $? != 0
    end
  end
end
