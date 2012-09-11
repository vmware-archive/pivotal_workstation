pivotal_workstation_package "JavaForOSX" do
  source "http://support.apple.com/downloads/DL1572/en_US/"
  volumes_dir "Java for OS X 2012-005"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "e0750c72972b8a2ccbcb3144bb31d74419276387"
end
