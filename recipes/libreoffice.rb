dmg_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source "http://download.documentfoundation.org/libreoffice/stable/3.6.3/mac/x86/LibO_3.6.3_MacOS_x86_install_en-US.dmg"
  checksum "d8537892049c053f91aff569a72c67bfd7559be4340588484025cf2d73adff5a"
  owner WS_USER
  action :install
end
