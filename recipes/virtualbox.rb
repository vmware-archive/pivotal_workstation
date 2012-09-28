pivotal_workstation_package "VirtualBox" do
  source "http://download.virtualbox.org/virtualbox/4.1.22/VirtualBox-4.1.23-80870-OSX.dmg"
  checksum "a73bdf9210868d3aeccbc6163445b2dd588a8ab591a8cf7005452673f7e6ba33"
  action :install
  type "pkg"
  package_id "org.virtualbox.pkg.virtualbox"
end
