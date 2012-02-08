pivotal_workstation_package "JavaForMacOSX10.7" do
  source "http://support.apple.com/downloads/DL1421/en_US/JavaForMacOSX10.7.dmg"
  volumes_dir "Java for Mac OS X 10.7"
  action :install
  type "mpkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "f12f356c5788abaf48434fa16f5f69f4e10ae3caab08e0c2d81924336fc4e292"
end
