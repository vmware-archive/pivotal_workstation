run_unless_marker_file_exists("skype_5_beta") do
  execute "download skype to temp dir" do
    command "curl -o /tmp/skype.dmg http://download.skype.com/macosx/Skype_5.0.0.6378.dmg"
    user WS_USER
  end
  
  execute "mount dmg" do
    command "hdid /tmp/skype.dmg"
    user WS_USER
  end
  
  execute "copy skype to /Applications" do
    command 'cp -rf /Volumes/Skype/Skype.app /Applications/'
    user WS_USER
  end
  
  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/Skype"
    user WS_USER
  end
end
