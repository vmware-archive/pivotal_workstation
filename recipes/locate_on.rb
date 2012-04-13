execute "load locate daemon via launchctl"   do
  command "launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
  not_if "launchctl list | grep locate"
end

execute "check launchd is running" do
  command "launchctl list | grep locate"
end
