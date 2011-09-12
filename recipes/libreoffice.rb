pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice 3.3"
  source "http://download.documentfoundation.org/libreoffice/stable/3.3.4/mac/x86/LibO_3.3.4_MacOS_x86_install_en-US.dmg"
  checksum "6a6abd0287606fcfedb0ef9bcdf976516a79a09ae81c1734cc82e9ac05b0d7d5"
  action :install
end
