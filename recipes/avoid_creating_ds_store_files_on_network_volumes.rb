pivotal_workstation_defaults "Avoid creating .DS_Store files on network volumes" do
  domain 'com.apple.desktopservices'
  key 'DSDontWriteNetworkStores'
  boolean true
end
