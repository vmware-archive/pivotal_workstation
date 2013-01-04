pivotal_workstation_defaults "Disable disk image verification 1" do
  domain 'com.apple.frameworks.diskimages'
  key 'skip-verify'
  boolean true
end

pivotal_workstation_defaults "Disable disk image verification 2" do
  domain 'com.apple.frameworks.diskimages'
  key 'skip-verify-locked'
  boolean true
end

pivotal_workstation_defaults "Disable disk image verification 3" do
  domain 'com.apple.frameworks.diskimages'
  key 'skip-verify-remote'
  boolean true
end
