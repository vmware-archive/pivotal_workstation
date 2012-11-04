dmg_package "VirtualBox" do
  source "http://download.virtualbox.org/virtualbox/4.2.0/VirtualBox-4.2.1-80871-OSX.dmg"
  checksum "dda9cc85e4dfdc07b8c32e7286ac2963fcce2f2d42c24367992697aada1b6166"
  action :install
  type "pkg"
  package_id "org.virtualbox.pkg.virtualbox"
end
