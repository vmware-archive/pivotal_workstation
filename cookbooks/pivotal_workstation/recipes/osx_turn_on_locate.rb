run_unless_marker_file_exists("located_activated") do
  execute "load locate daemon via launchctl"   do
    command "launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
  end
  
  execute "check launchd is running" do
    command "launchctl list | grep locate"
  end
end