##  This is very experimental and unsupported.  Don't expect it to work,
##  though it seems to work OK.

run_unless_marker_file_exists("google_chrome") do
  execute "download chrome to temp dir" do
    command "curl -o /tmp/googlechrome.dmg #{node["chrome_download_location"]}"
    user WS_USER
  end
  
  execute "mount chrome dmg" do
    command "hdid /tmp/googlechrome.dmg"
    user WS_USER
  end
  
  execute "copy chrome to /Applications" do
    command 'cp -rf /Volumes/Google\\ Chrome/Google\\ Chrome.app /Applications/'
  end
  
  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/Google\\ Chrome/"
    user WS_USER
  end
end
