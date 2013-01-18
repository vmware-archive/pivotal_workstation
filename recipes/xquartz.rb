dmg_package "XQuartz" do
  source "http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.4.dmg"
  action :install
  volumes_dir "XQuartz-2.7.4"
  checksum "3f7c156fc4b13e3f0d0e44523ef2bd3cf7ea736126616dd2da28abb31840923c"
  type "pkg"
  owner WS_USER
  package_id "org.macosforge.xquartz.pkg"
end
