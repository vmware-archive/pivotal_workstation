if node["platform"] == "mac_os_x"
  dmg_package "Firefox" do
    source "http://download.mozilla.org/?product=firefox-17.0&os=osx&lang=en-US"
    checksum "abd7e8a4da8faf815d0bd96a6b1a6492e630c73433522c0c3dfd671f46cc2236"
    action :install
    owner WS_USER
  end
else
  # CentOS: this depends upon the "remi" repo (or similar)
  # already being pre-configured for yum.
  package "firefox"
end
