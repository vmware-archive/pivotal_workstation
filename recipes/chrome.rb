pivotal_workstation_package "Google Chrome" do
  dmg_name "googlechrome"
  source "https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg"
  checksum "bd85e06643abc3af5b1a049d8031c29f339f456c2d25852a7a4a1e6578b49792"
  action :install
end
