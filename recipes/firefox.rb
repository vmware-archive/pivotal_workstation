pivotal_workstation_package "Firefox" do
  source "http://download.mozilla.org/?product=firefox-16.0.1&os=osx&lang=en-US"
  action :install
  user WS_USER
  checksum "5911843c3b4c2a55105ceacba8a377bce897c984ee202bed963df34089fecae9"
end
