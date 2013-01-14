dmg_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source "http://download.documentfoundation.org/libreoffice/stable/3.6.4/mac/x86/LibO_3.6.4_MacOS_x86_install_en-US.dmg"
  checksum "4eb29ef38e009214e920fcd98ba0b4aaf2e4fd1d9e27ef5cb466af7ccaf64f88"
  owner WS_USER
  action :install
end
