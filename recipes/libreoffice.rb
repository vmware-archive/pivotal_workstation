node.default["libreoffice"]["source"] = "http://download.documentfoundation.org/libreoffice/stable/3.5.2/mac/x86/LibO_3.5.2_MacOS_x86_install_en-US.dmg"
node.default["libreoffice"]["checksum"] = "8d43111f2ddc93aced890d14cb20b6d5f74b5a5cf99badbb6d3da12b959382b8"

pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source node["libreoffice"]["source"]
  checksum node["libreoffice"]["checksum"]
  action :install
end
