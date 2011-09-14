pivotal_workstation_package "VirtualBox" do
  source "http://download.virtualbox.org/virtualbox/4.1.2/VirtualBox-4.1.2-73507-OSX.dmg"
  checksum "6fd7b3ed2596cd76004e6d1a8d5ddbfb4193d6508132bfa447304c9cff5703d7"
  action :install
  type "mpkg"
  package_id "org.virtualbox.pkg.virtualbox"
end