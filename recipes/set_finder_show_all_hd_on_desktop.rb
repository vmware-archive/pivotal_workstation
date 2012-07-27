pivotal_workstation_defaults "show hard drive on desktop" do
  domain 'com.apple.finder'
  key 'ShowHardDrivesOnDesktop'
  boolean true
end

pivotal_workstation_defaults "show external hard drives on desktop" do
  domain 'com.apple.finder'
  key 'ShowExternalHardDrivesOnDesktop'
  boolean true
end

pivotal_workstation_defaults "show removable media on desktop" do
  domain 'com.apple.finder'
  key 'ShowRemovableMediaOnDesktop'
  boolean true
end