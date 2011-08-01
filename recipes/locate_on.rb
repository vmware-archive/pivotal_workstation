execute "turn locate on" do
  command "launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist"
  user WS_USER
end
