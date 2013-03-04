dmg_package "Firefox" do
  source "http://download.mozilla.org/?product=firefox-19.0&os=osx&lang=en-US"
  checksum "4585e65043d5c7ea45534216706c15a1a2ae6fba0b457b83db550a5546b1422b"
  action :install
  owner WS_USER
end
