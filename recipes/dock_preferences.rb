pivotal_workstation_defaults "set dock to be on left" do
  domain "com.apple.dock"
  key "orientation"
  string node["dock_preferences"]["orientation"]
end

pivotal_workstation_defaults "set dock to autohide" do
  domain "com.apple.dock"
  key "autohide"
  boolean node["dock_preferences"]["autohide"]
end

execute "relaunch dock" do
  command "killall Dock"
end
