dmg_package "VirtualBox" do
  source "http://download.virtualbox.org/virtualbox/4.2.4/VirtualBox-4.2.4-81684-OSX.dmg"
  checksum "6908705667dda65932005318ee16bff5ca0ba9dfdc89e9e7bf86a9f7469bcbf5"
  action :install
  owner WS_USER
  type "pkg"
  package_id "org.virtualbox.pkg.virtualbox"
end
