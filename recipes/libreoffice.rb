dmg_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source "http://download.documentfoundation.org/libreoffice/stable/4.0.0/mac/x86/LibreOffice_4.0.0_MacOS_x86.dmg"
  checksum "2ef287af5a94561fadf0d91a8a11ce936f97f59d360f1c6caa275fd601735c2f"
  owner WS_USER
  action :install
end
