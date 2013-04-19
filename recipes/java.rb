Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

return unless node["platform"] == "mac_os_x"

dmg_package "JavaForOSX" do
  source "http://support.apple.com/downloads/DL1572/en_US/"
  volumes_dir "Java for OS X 2013-003"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "193daf9d16ba753cb7b9160e3b3842e515575a07ac2ec06d27c21a40c30c917b"
end
