execute "ask for password when screen is locked" do
  command "defaults write com.apple.screensaver askForPassword -int 1"
  user WS_USER
end

execute "wait 60 seconds between screensaver & lock" do
  command "defaults write com.apple.screensaver askForPasswordDelay 60"
  user WS_USER
end

plist_dir = ENV['HOME'] + "/Library/Preferences/ByHost"
Dir["#{plist_dir}/com.apple.screensaver.*.plist"].each do |file|
  execute "set screensaver timeout" do
    command "defaults write #{file.chomp(".plist")} idleTime 600"
    user WS_USER
  end
end

execute "set display, disk and computer sleep times" do
  command "pmset -a displaysleep 20 disksleep 15 sleep 0"
end
