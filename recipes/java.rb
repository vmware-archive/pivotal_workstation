return unless node["platform"] == "mac_os_x"

dmg_package "JavaForOSX" do
  source "http://support.apple.com/downloads/DL1572/en_US/"
  volumes_dir "Java for OS X 2012-006"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "6d947f4a20e8f7ee35bb460675ad0b930f8acc15ee0b0dbfc791a7a02abed6c0"
end
