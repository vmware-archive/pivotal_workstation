dmg_package "Google Chrome" do
  dmg_name "googlechrome"
  source "https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg"
  checksum "6d8c6f96c3ebc3a2688efb9d26bd67282c13d90097578782aa7d05a0b1458bfa"
  action :install
  owner WS_USER
end
