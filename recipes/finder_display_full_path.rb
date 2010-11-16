execute "set finder to display full path in title bar" do
  command "defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES"
  user WS_USER
end