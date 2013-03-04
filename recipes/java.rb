return unless node["platform"] == "mac_os_x"

dmg_package "JavaForOSX" do
  source "http://support.apple.com/downloads/DL1572/en_US/"
  volumes_dir "Java for OS X 2013-001"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "5c6f709b747a9c067580accf260a18cadba13ad16203adf8238929b5b2869f8b"
end
