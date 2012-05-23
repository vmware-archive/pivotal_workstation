pivotal_workstation_package "JavaForOSX" do
  source "http://support.apple.com/downloads/DL1515/en_US/"
  volumes_dir "Java for OS X 2012-003"
  action :install
  type "pkg"
  package_id "com.apple.pkg.JavaForMacOSX107hklj"
  checksum "c9cf7cb663eb86e6d7598c2e9c82b00e039b391622802cbfdb03defbd47ba070"
end
