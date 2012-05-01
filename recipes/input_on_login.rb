execute "Turn on Input menu in login screen (dvorak vs qwerty)" do
  command "defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true"
end
