execute "TimeMachine should NOT ask to use every new disk"   do
  command "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES"
  user WS_USER
end

old_menu_extras = `sudo -u #{WS_USER} defaults read com.apple.systemuiserver menuExtras`
new_menu_extras = old_menu_extras.split("\n").select { |line| line !~ /TimeMachine.menu/ }.join("\n")

execute "TimeMachine should NOT appear in the status bar" do
  command "defaults write com.apple.systemuiserver menuExtras \'#{new_menu_extras}\'"
  user WS_USER
  only_if { new_menu_extras != old_menu_extras }
  notifies :run, "execute[restart SustemUIServer]"
end

execute "restart SustemUIServer" do
  command "killall -HUP SystemUIServer"
  action :nothing
end

execute "make sure it doesn't exist"   do
  command "! defaults read com.apple.systemuiserver menuExtras | grep TimeMachine.menu"
  user WS_USER
end
