execute "show hard drive on desktop" do
  command "defaults write com.apple.finder ShowHardDrivesOnDesktop -bool YES"
  user WS_USER
end

execute "show external hard drives on desktop" do
  command "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool YES"
  user WS_USER
end

execute "show removable media on desktop" do
  command "defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool YES"
  user WS_USER
end
