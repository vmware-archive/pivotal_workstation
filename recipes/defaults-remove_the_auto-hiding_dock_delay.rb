pivotal_workstation_defaults "Remove the auto-hiding Dock delay" do
  domain 'com.apple.dock'
  key 'autohide-delay'
  float 0
end
