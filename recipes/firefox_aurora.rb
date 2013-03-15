#Installs Firefox Aurora (Pre Beta Build of Firefox)
#http://www.mozilla.org/en-US/firefox/aurora/
dmg_package "Firefox Aurora" do
  volumes_dir "Aurora"
  app "FirefoxAurora"
  source "https://ftp.mozilla.org/pub/mozilla.org/firefox/nightly/latest-mozilla-aurora/firefox-21.0a2.en-US.mac.dmg"
  action :install
  owner WS_USER
end
