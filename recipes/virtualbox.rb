pivotal_workstation_package "VirtualBox" do
  source "http://download.virtualbox.org/virtualbox/4.1.20/VirtualBox-4.1.20-80170-OSX.dmg"
  checksum "43e773eb425f6da4e6329dc146571b3e0166a5f4f54075c0f78cfec81057033e"
  action :install
  type "mpkg"
  package_id "org.virtualbox.pkg.virtualbox"
end
