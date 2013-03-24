return unless node["platform"] == "mac_os_x"

dmg_package "JavaForOSX" do
  source "http://support.apple.com/downloads/DL1572/en_US/"
  volumes_dir "Java for OS X 2013-002"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "0ac0ab9bd1990add28bb1fa088fb8e59b657a09cbf5fde1c9d38eea8459760cc"
end
