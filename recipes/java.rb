pivotal_workstation_package "JavaForMacOSX10.7" do
  source "http://support.apple.com/downloads/DL1421/en_US/JavaForMacOSX10.7.dmg"
  volumes_dir "Java for Mac OS X 10.7"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107"
  checksum "a1b493280c0854f5b7357dab00115db2db48df6463ba7c53c5fd10675c066783"
end
