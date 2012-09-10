pivotal_workstation_package "XQuartz" do
  source "http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.3.dmg"
  action :install
  volumes_dir "XQuartz-2.7.3"
  checksum "3e8d0b4ff0bb5325d653f3d2a58a11a212fa63a893a0b2d8e7c7edcc8d9bb4bd"
  type "pkg"
  package_id "org.macosforge.xquartz.pkg"
end
