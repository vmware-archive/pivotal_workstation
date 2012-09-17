pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source "http://download.documentfoundation.org/libreoffice/stable/3.6.1/mac/x86/LibO_3.6.1_MacOS_x86_install_en-US.dmg"
  checksum "2c60e1e1f9ae1e84230fb541e961272c4c75f0826f8d590e9bfb8ba2a859f505"
  action :install
end
