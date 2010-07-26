execute "set dock to be on left" do
  command "defaults write com.apple.dock orientation -string left"
  user WS_USER
end

execute "set dock to autohide" do
  command "defaults write com.apple.dock autohide -boolean true"
  user WS_USER
end

execute "relaunch dock" do
  command "killall Dock"
end