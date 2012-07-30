pivotal_workstation_package "XQuartz" do
  source "http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.2.dmg"
  action :install
  volumes_dir "XQuartz-2.7.2"
  checksum "83ef52c93cd98213a6b847c3429359433d8cc16937007ba7ba41ad5588b6fd82"
  type "pkg"
  package_id "org.macosforge.xquartz.pkg"
end
