dmg_package "Firefox" do
  source "http://download.mozilla.org/?product=firefox-18.0.2&os=osx&lang=en-US"
  checksum "3987f23ab8eca77ec63007333f2314743d4fb4c791db2a2820841869ef015c8b"
  action :install
  owner WS_USER
end
