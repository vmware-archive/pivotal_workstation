node.default["libreoffice"]["source"] = "http://download.documentfoundation.org/libreoffice/stable/3.5.5/mac/x86/LibO_3.5.5_MacOS_x86_install_en-US.dmg"
node.default["libreoffice"]["checksum"] = "a6edaaf2c257d04fc33f8dbaaab9a98feb407e73bf33c5e6ec873b0b08413af4"

pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source node["libreoffice"]["source"]
  checksum node["libreoffice"]["checksum"]
  action :install
end
