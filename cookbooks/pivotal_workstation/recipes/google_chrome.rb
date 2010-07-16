##  This is very experimental and unsupported.  Don't expect it to work,
##  though it seems to work OK.

run_unless_marker_file_exists("google_chrome") do
  execute "download chrome to temp dir" do
    command "curl -o /tmp/googlechrome.dmg http://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
    user WS_USER
  end
  
  execute "mount chrome dmg" do
    command "hdid /tmp/googlechrome.dmg"
    user WS_USER
  end
  
  execute "copy chrome to /Applications" do
    command 'cp -r /Volumes/Google\\ Chrome/Google\\ Chrome.app /Applications/'
    user WS_USER
  end
  
  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/Google\\ Chrome/"
    user WS_USER
  end
end
