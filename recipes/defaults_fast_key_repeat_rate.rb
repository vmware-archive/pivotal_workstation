execute "set key repeat rate to fast" do
  command "defaults write ~/Library/Preferences/.GlobalPreferences KeyRepeat -int 2"
  user WS_USER
end

execute "set key initial repeat delay to short" do
  command "defaults write ~/Library/Preferences/.GlobalPreferences InitialKeyRepeat -int 15"
  user WS_USER
end

