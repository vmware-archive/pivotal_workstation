pivotal_workstation_defaults "Remove the auto-hiding Dock delay" do
  domain 'com.apple.dock'
  key 'autohide-time-modifier'
  float 0
end
