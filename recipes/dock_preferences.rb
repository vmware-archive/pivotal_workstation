pivotal_workstation_defaults "set dock to be on left" do
  plist "com.apple.dock"
  key "orientation"
  string "left"
end

execute "set dock to autohide" do
  command "defaults write com.apple.dock autohide -boolean true"
  user WS_USER
end

execute "relaunch dock" do
  command "killall Dock"
end
