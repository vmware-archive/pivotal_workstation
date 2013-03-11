dmg_package "VirtualBox" do
  source "http://download.virtualbox.org/virtualbox/4.2.8/VirtualBox-4.2.8-83876-OSX.dmg"
  checksum "e090da9766a1780a4f1fc6b3b85fe8b7ce71c8030d1fda9e7178716009d69a33"
  action :install
  owner WS_USER
  type "pkg"
  package_id "org.virtualbox.pkg.virtualbox"
end
