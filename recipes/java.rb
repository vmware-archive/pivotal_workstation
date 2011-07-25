`pkgutil --pkgs=com.apple.pkg.JavaForMacOSX107`
if $? != 0
  #raise "Java not installed!"

  remote_file "/tmp/java.dmg" do
    source node["java_download_uri"]
    mode "0644" 
  end

  execute "mount java dmg" do
    command "hdid /tmp/java.dmg"
    user WS_USER
  end

  execute "intall java" do
    command "installer -pkg /Volumes/Java\\ for\\ Mac\\ OS\\ X\\ 10.7/JavaForMacOSX10.7.pkg -target /"
  end

  execute "unmount dmg" do
    command "hdiutil detach /Volumes/Google\\ Chrome"
    user WS_USER
  end

  ruby_block "test to see if Chrome was installed" do
    block do
      `pkgutil --pkgs=com.apple.pkg.JavaForMacOSX107`
      raise "Java install failed" if $? != 0
    end
  end
end
