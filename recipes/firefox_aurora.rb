# coding: UTF-8

#Installs Firefox Aurora (Pre Beta Build of Firefox)
#http://www.mozilla.org/en-US/firefox/aurora/
dmg_package "Firefox Aurora" do
  dmg_name "firefox-21.0a2.en-US.mac"
  source "https://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/firefox-21.0a2.en-US.mac.dmg"
  checksum "6afdb582f5c618b4dea4d0fba51aefa99c63d5d509103c89e0fc1ab072853387"
  action :install
  owner WS_USER
end
