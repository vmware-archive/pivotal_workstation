dmg_package "Google Chrome" do
  dmg_name "googlechrome"
  source "https://dl-ssl.google.com/chrome/mac/stable/GGRM/googlechrome.dmg"
  checksum "67de3a3a1d4a130912c5e31c9e2917585b3ec85b927d1498c89f9a360d4e052b"
  action :install
  owner WS_USER
end
