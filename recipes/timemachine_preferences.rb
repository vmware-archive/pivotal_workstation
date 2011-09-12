execute "TimeMachine should NOT ask to use every new disk"   do
  command "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES"
  user WS_USER
end

ruby_block "TimeMachine should NOT appear in the status bar" do
  block do 
    new_menuExtras=""
    `sudo -u #{WS_USER} defaults read com.apple.systemuiserver menuExtras`.split("\n").each do |line|
      if line !~ /TimeMachine.menu/
	new_menuExtras = new_menuExtras + line + "\n"
      end
    end
    `sudo -u #{WS_USER} defaults write com.apple.systemuiserver menuExtras \'#{new_menuExtras}\'`
    `killall -HUP SystemUIServer`
  end
end

execute "make sure it doesn't exist"   do
  command "! defaults read com.apple.systemuiserver menuExtras | grep TimeMachine.menu"
  user WS_USER
end
