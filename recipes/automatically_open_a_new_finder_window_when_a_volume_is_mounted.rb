pivotal_workstation_defaults "Automatically open a new Finder window when a volume is mounted 1" do
  domain 'com.apple.frameworks.diskimages'
  key 'auto-open-ro-root'
  boolean true
end

pivotal_workstation_defaults "Automatically open a new Finder window when a volume is mounted 2" do
  domain 'com.apple.frameworks.diskimages'
  key 'auto-open-rw-root'
  boolean true
end

pivotal_workstation_defaults "Automatically open a new Finder window when a volume is mounted 3" do
  domain 'com.apple.finder'
  key 'OpenWindowForNewRemovableDisk'
  boolean true
end
