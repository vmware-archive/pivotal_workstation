execute "Disable menu bar transparency" do
  # from http://knoopx.net/2011/10/28/os-x-lion-tweaks
  command "defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false"
end
