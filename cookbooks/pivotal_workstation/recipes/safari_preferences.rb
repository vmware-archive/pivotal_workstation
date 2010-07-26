execute "set safari to show status bar" do
  command "defaults write com.apple.safari ShowStatusBar -bool YES"
  user WS_USER
end