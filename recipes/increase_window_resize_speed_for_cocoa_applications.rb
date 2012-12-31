pivotal_workstation_defaults "Increase window resize speed for Cocoa applications" do
  domain 'NSGlobalDomain'
  key 'NSWindowResizeTime'
  float 0.001
end
