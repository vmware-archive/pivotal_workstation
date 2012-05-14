node.default["libreoffice"]["source"] = "http://download.documentfoundation.org/libreoffice/stable/3.5.3/mac/x86/LibO_3.5.3_MacOS_x86_install_en-US.dmg"
node.default["libreoffice"]["checksum"] = "fb96e2c6a87eb36aae000829041ddfbcc129d360610c2e450e57f89e102fef3e"

pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source node["libreoffice"]["source"]
  checksum node["libreoffice"]["checksum"]
  action :install
end
