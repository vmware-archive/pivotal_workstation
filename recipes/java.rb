pivotal_workstation_package "JavaForMacOSX10.7" do
  source "http://support.apple.com/downloads/DL1421/en_US/JavaForMacOSX10.7.dmg"
  volumes_dir "Java for Mac OS X 10.7"
  action :install
  type "mpkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "4c32d32cfeaaf4aab539a1385c4f55a97cf09c7d396f8b43257161616bba7070"
end
