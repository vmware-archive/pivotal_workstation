pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source "http://download.documentfoundation.org/libreoffice/stable/3.6.2/mac/x86/LibO_3.6.2_MacOS_x86_install_en-US.dmg"
  checksum "b0edd3dc065ba1e061a3073d7ee6125d7e7c12ff7dee06132fa9d792feb1ec72"
  action :install
end
