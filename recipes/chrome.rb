pivotal_workstation_package "Google Chrome" do
  dmg_name "googlechrome"
  source "https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg"
  checksum "7daa2dc5c46d9bfb14f1d7ff4b33884325e5e63e694810adc58f14795165c91a"
  action :install
end
