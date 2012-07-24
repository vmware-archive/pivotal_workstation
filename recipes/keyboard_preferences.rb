pivotal_workstation_defaults "Enable full keyboard access for all controls" do
  # from http://knoopx.net/2011/10/28/os-x-lion-tweaks
  plist "NSGlobalDomain"
  key "AppleKeyboardUIMode"
  integer 3
end
